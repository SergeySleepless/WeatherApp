//
//  WeatherByDayCell.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 10.10.2020.
//

import UIKit

class WeatherByDayCell: UITableViewCell {
    
    static let identifier = "WeatherByDayCell"
    
    let dayNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 19)
        return view
    }()
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let maxTempLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 19)
        return view
    }()
    
    let minTempLabel: UILabel = {
        let view = UILabel()
        view.alpha = 0.6
        view.font = .systemFont(ofSize: 19)
        return view
    }()
    
    let tempStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 16
        return view
    }()
    
    let stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalCentering
        return view
    }()
    
    func setupView() {
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        dayNameLabel.snp.makeConstraints { (make) in
            make.width.equalTo(130)
        }
        tempStackView.addArrangedSubview(maxTempLabel)
        tempStackView.addArrangedSubview(minTempLabel)
        stackView.addArrangedSubview(dayNameLabel)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(tempStackView)
        backgroundColor = .clear
    }
    
}
