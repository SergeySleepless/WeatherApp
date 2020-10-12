//
//  WeathersByTimeDataSource.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 11.10.2020.
//

import UIKit

class WeathersByTimeDataSource: NSObject {
    
    let weathersByHTime: [Weather.FetchWeather.ViewModel.WeatherByTime]
    
    init(weathersByHours: [Weather.FetchWeather.ViewModel.WeatherByTime]) {
        self.weathersByHTime = weathersByHours
    }
}
