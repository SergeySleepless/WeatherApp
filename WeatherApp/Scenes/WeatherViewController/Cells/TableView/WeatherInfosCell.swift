//
//  WeatherInfosCell.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 11.10.2020.
//

import UIKit

class WeatherInfosCell: UITableViewCell {
    
    static let identifier = "WeatherInfosCell"
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.rowHeight = 50
        view.isScrollEnabled = false
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.register(WeatherInfoCell.self, forCellReuseIdentifier: WeatherInfoCell.identifier)
        return view
    }()
    
    func setupView(dataSource: WeatherInfoDataSource) {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        separatorInset = .zero
        backgroundColor = .clear
        setDataSource(dataSource: dataSource)
    }
    
    private func setDataSource(dataSource: WeatherInfoDataSource) {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }
    
}
