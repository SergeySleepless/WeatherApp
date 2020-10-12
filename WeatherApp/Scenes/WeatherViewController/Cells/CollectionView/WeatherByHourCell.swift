//
//  WeatherByTimeCell.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 11.10.2020.
//

import UIKit

class WeatherByTimeCell: UICollectionViewCell {
    
    static let identifier = "WeatherByTimeCell"
    
    let timeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18)
        view.textAlignment = .center
        return view
    }()
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let temperatureLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18)
        view.textAlignment = .center
        return view
    }()
    
    let stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        return view
    }()
    
    func setupViews() {
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(temperatureLabel)
    }
    
}
