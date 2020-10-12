//
//  WeatherInfoDataSource.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 11.10.2020.
//

import UIKit

class WeatherInfoDataSource: NSObject {
    
    let weatherInfo: Weather.FetchWeather.ViewModel.WeatherInfo
    
    init(weatherInfo: Weather.FetchWeather.ViewModel.WeatherInfo) {
        self.weatherInfo = weatherInfo
    }
    
}

extension WeatherInfoDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Weather.FetchWeather.ViewModel.WeatherInfo.Titles.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInfoCell.identifier) as! WeatherInfoCell
        cell.setupView()
        let mirror = Mirror(reflecting: weatherInfo)
        cell.title.text = Weather.FetchWeather.ViewModel.WeatherInfo.Titles.allCases[indexPath.row].rawValue
        let value = mirror.children.compactMap({ $0.value as? String })[indexPath.row]
        cell.info.text = value
        return cell
    }
}

extension WeatherInfoDataSource: UITableViewDelegate {
    
}
