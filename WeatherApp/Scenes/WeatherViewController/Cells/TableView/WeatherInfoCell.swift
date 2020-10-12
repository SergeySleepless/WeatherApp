//
//  WeatherInfoCell.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 11.10.2020.
//

import UIKit

class WeatherInfoCell: UITableViewCell {
    
    static let identifier = "WeatherInfoCell"
    
    let title: UILabel = {
        let view = UILabel()
        view.alpha = 0.6
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let info: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 22)
        return view
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    func setupView() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(info)
        backgroundColor = .clear
    }
    
}
