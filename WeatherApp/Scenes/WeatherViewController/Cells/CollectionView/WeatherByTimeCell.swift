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
        view.distribution = .fillEqually
        view.spacing = 16
        return view
    }()
    
    func setupView() {
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(130)
        }
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(temperatureLabel)
        backgroundColor = .clear
    }
    
}
