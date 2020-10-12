//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 13.10.2020.
//

import UIKit

class LoadingView: UIView {
    
    private let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
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
        addSubview(activityView)
        activityView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        backgroundColor = .black
    }
    
}
