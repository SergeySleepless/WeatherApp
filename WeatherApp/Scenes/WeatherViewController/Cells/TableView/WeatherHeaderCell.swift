//
//  WeatherHeaderCell.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 09.10.2020.
//

import UIKit
import SnapKit

class WeatherHeaderCell: UITableViewCell {
    
    static let identifier = "WeatherHeaderCell"
    
    let cityNameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 32)
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let temperatureLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 80, weight: .thin)
        return view
    }()
    
    let temperatureMaxMinLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 7
        return view
    }()
    
    private let topStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 7
        return view
    }()
    
    private let botStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 2
        return view
    }()
    
    func setupViews() {
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.bottom.equalToSuperview().inset(80)
        }
        
        topStackView.addArrangedSubview(cityNameLabel)
        topStackView.addArrangedSubview(descriptionLabel)
        
        botStackView.addArrangedSubview(temperatureLabel)
        botStackView.addArrangedSubview(temperatureMaxMinLabel)
        
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(botStackView)
        
        separatorInset = .zero
        backgroundColor = .clear
    }
    
}
