//
//  WeathersByTimesCell.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 11.10.2020.
//

import UIKit
import SnapKit

class WeathersByTimesCell: UITableViewCell {
    
    static let identifier = "WeathersByTimesCell"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.register(WeatherByTimeCell.self, forCellWithReuseIdentifier: WeatherByTimeCell.identifier)
        return view
    }()
    
    func setupView(dataSource: WeathersByTimeDataSource) {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        separatorInset = .zero
        backgroundColor = .clear
        setDataSource(dataSource: dataSource)
    }
    
    private func setDataSource(dataSource: WeathersByTimeDataSource) {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.reloadData()
    }
    
}
