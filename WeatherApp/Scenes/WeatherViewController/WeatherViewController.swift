//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 09.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SetImageDelegate: class {
    func setImage(imageView: UIImageView, imageId: String)
}

protocol WeatherDisplayLogic: class {
    func displayWeather(viewModel: Weather.FetchWeather.ViewModel)
    func displayBackgroundImageUrl(viewModel: Weather.FetchBackgroundImage.ViewModel)
    func displayNeedsPermissionView()
    func displayLoadingView()
}

class WeatherViewController: UIViewController {
    
    var interactor: WeatherBusinessLogic?
    var router: (NSObjectProtocol & WeatherRoutingLogic & WeatherDataPassing)?
    lazy var configurator: WeatherConfigurationLogic = WeatherConfgurator()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configurator.configure(with: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var dataSource: WeatherDataSource?
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.allowsSelection = false
        view.tableFooterView = UIView()
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(WeatherHeaderCell.self, forCellReuseIdentifier: WeatherHeaderCell.identifier)
        view.register(WeathersByDaysCell.self, forCellReuseIdentifier: WeathersByDaysCell.identifier)
        view.register(WeatherInfosCell.self, forCellReuseIdentifier: WeatherInfosCell.identifier)
        view.register(WeathersByTimesCell.self, forCellReuseIdentifier: WeathersByTimesCell.identifier)
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    private let needsPermissionView: NeedsPermissionView = {
        let view = NeedsPermissionView()
        return view
    }()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.requestLocation()
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        overrideUserInterfaceStyle = .dark
    }
    
    private func setupNeedsPermissionView() {
        view.addSubview(needsPermissionView)
        needsPermissionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: Display Logic

extension WeatherViewController: WeatherDisplayLogic {
    func displayWeather(viewModel: Weather.FetchWeather.ViewModel) {
        dataSource = .init(viewModel: viewModel, delegate: self)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
            self.loadingView.removeFromSuperview()
            self.needsPermissionView.removeFromSuperview()
    }
    
    func displayBackgroundImageUrl(viewModel: Weather.FetchBackgroundImage.ViewModel) {
        let urlString = viewModel.urlString
        let request = Weather.SetImage.Request(imageView: backgroundImageView, urlString: urlString)
        interactor?.setImage(request: request)
    }
    
    func displayNeedsPermissionView() {
            self.loadingView.removeFromSuperview()
            self.needsPermissionView.removeFromSuperview()
            self.setupNeedsPermissionView()
    }
    
    func displayLoadingView() {
        setupLoadingView()
    }
}

extension WeatherViewController: SetImageDelegate {
    func setImage(imageView: UIImageView, imageId: String) {
        guard !imageId.isEmpty else { return }
        let urlString = Constants.Weather.imagesUrl + "\(imageId)@2x.png"
        let request = Weather.SetImage.Request(imageView: imageView, urlString: urlString)
        interactor?.setImage(request: request)
    }
}
