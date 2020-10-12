//
//  WeathersByDaysCell.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 10.10.2020.
//

import UIKit

class WeathersByDaysCell: UITableViewCell {
    
    static let identifier = "WeathersByDaysCell"
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.allowsSelection = false
        view.isScrollEnabled = false
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.register(WeatherByDayCell.self, forCellReuseIdentifier: WeatherByDayCell.identifier)
        return view
    }()
    
    func setupView(dataSource: WeathersByDaysDataSource) {
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        separatorInset = .zero
        backgroundColor = .clear
        setDataSource(dataSource: dataSource)
        tableView.reloadData()
    }
    
    private func setDataSource(dataSource: WeathersByDaysDataSource) {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
}
