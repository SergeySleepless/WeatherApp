//
//  NeedsPermissionView.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 13.10.2020.
//

import UIKit

class NeedsPermissionView: UIView {
    
    let label: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 25)
        view.text = "Для работы необходимо разрешить определение геопозиции"
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backgroundColor = .black
    }
    
}
