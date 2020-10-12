//
//  WeathersByDaysDataSource.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 10.10.2020.
//

import UIKit

class WeathersByDaysDataSource: NSObject {
    
    let weatherByDays: [Weather.FetchWeather.ViewModel.WeatherByDay]
    weak var setImageDelegate: SetImageDelegate?
    
    init(weatherByDays: [Weather.FetchWeather.ViewModel.WeatherByDay], delegate: SetImageDelegate) {
        self.weatherByDays = weatherByDays
        self.setImageDelegate = delegate
    }
    
}

extension WeathersByDaysDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherByDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherByDayCell.identifier) as! WeatherByDayCell
        cell.setupView()
        let day = weatherByDays[indexPath.row]
        cell.dayNameLabel.text = day.dayName
        cell.maxTempLabel.text = day.temperatureMax
        cell.minTempLabel.text = day.temperatureMin
        setImageDelegate?.setImage(imageView: cell.iconImageView, imageId: day.imageId)
        return cell
    }
    
}

extension WeathersByDaysDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
