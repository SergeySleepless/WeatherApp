//
//  WeathersByTimeDataSource.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 11.10.2020.
//

import UIKit

class WeathersByTimeDataSource: NSObject {
    
    let weathersByTime: [Weather.FetchWeather.ViewModel.WeatherByTime]
    weak var setImageDelegate: SetImageDelegate?
    
    init(weathersByTime: [Weather.FetchWeather.ViewModel.WeatherByTime], delegate: SetImageDelegate) {
        self.weathersByTime = weathersByTime
        self.setImageDelegate = delegate
    }
}

extension WeathersByTimeDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathersByTime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherByTimeCell.identifier, for: indexPath) as! WeatherByTimeCell
        cell.setupView()
        let time = weathersByTime[indexPath.row]
        cell.temperatureLabel.text = time.temperature
        cell.timeLabel.text = time.time
        setImageDelegate?.setImage(imageView: cell.iconImageView, imageId: time.imageId)
        return cell
    }
}

extension WeathersByTimeDataSource: UICollectionViewDelegate {
    
}

extension WeathersByTimeDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 130)
    }
}
