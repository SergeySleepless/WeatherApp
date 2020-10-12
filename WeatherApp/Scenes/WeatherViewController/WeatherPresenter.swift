//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 09.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherPresentationLogic {
    func presentWeather(response: Weather.FetchWeather.Response)
    func presentBackgroundImageUrl(response: Weather.FetchBackgroundImage.Response)
    func presentNeedsPermissionView()
    func presentLoadingView()
}

class WeatherPresenter {
    
    weak var viewController: WeatherDisplayLogic?
    private let formatter: WeatherDateFormatter = Formatter()
    
    private func getMinTemp(day: [List]) -> String {
        return Int(day.map({ $0.main.temp }).min() ?? 0).description
    }
    
    private func getMaxTemp(day: [List]) -> String {
        return Int(day.map({ $0.main.temp }).max() ?? 0).description
    }
    
    private func getCurrentDay(lists: [List]) -> [List] {
        return lists.filter { Date().weekday() == formatter.getWeekday(date: $0.dtTxt) }
    }
    
    private func getHeader(weather: WeatherEntity) -> Weather.FetchWeather.ViewModel.Header {
        let currentDay = getCurrentDay(lists: weather.list)
        return .init(cityName: weather.city.name,
                     desc: weather.list[0].weather[0].weatherDescription,
                     temperature: "\(Int(weather.list[0].main.temp))°",
                     temperatureMaxMin: "Макс. \(getMaxTemp(day: currentDay))°, мин. \(getMinTemp(day: currentDay))°")
    }
    
    private func getWeatherByTime(weather: WeatherEntity) -> [Weather.FetchWeather.ViewModel.WeatherByTime] {
        let weatherByTime = weather.list.map { (list) in
            Weather.FetchWeather.ViewModel.WeatherByTime(time: formatter.getTime(date: list.dtTxt),
                                                         temperature: "\(Int(list.main.temp))°",
                                                         imageId: list.weather[0].icon)
        }
        return weatherByTime
    }
    
    private func getWeatherByDays(weather: WeatherEntity) -> [Weather.FetchWeather.ViewModel.WeatherByDay] {
        var list = weather.list
        list.removeAll { Date().weekday() == formatter.getWeekday(date: $0.dtTxt) }
        let daysDictionary = Dictionary(grouping: list) { (day) in
            formatter.getWeekday(date: day.dtTxt)
        }
        let days = daysDictionary.sorted(by: { $0.0 < $1.0 }).map { (dict) in
            dict.value
        }
        let weatherByDays = days.map({ (day)  in
            Weather.FetchWeather.ViewModel.WeatherByDay.init(dayName: formatter.getWeekdayName(date: day[0].dtTxt),
                                                             imageId: day.middle?.weather[0].icon ?? "",
                                                             temperatureMax: getMaxTemp(day: day),
                                                             temperatureMin: getMinTemp(day: day))
        })
        return weatherByDays
    }
    
    private func getWeatherInfo(weather: WeatherEntity) -> Weather.FetchWeather.ViewModel.WeatherInfo {
        let list = weather.list[0]
        return .init(feelsLike: "\(Int(list.main.feelsLike))°",
                     pressure: "\(list.main.pressure) гПа",
                     humidity: "\(list.main.humidity) %",
                     clouds: "\(list.clouds.all) %",
                     windSpeed: "\(list.wind.speed) м/с",
                     windDeg: "\(list.wind.deg)°",
                     visibility: "\(list.visibility) м")
    }
    
}

extension WeatherPresenter: WeatherPresentationLogic {
    func presentWeather(response: Weather.FetchWeather.Response) {
        let weather = response.weather
        let viewModel = Weather.FetchWeather.ViewModel(header: getHeader(weather: weather),
                                                       weatherByTimes: getWeatherByTime(weather: weather),
                                                       weatherByDays: getWeatherByDays(weather: weather),
                                                       weatherInfo: getWeatherInfo(weather: weather))
        viewController?.displayWeather(viewModel: viewModel)
    }
    
    func presentBackgroundImageUrl(response: Weather.FetchBackgroundImage.Response) {
        viewController?.displayBackgroundImageUrl(viewModel: .init(urlString: response.urlString))
    }
    
    func presentNeedsPermissionView() {
        viewController?.displayNeedsPermissionView()
    }
    
    func presentLoadingView() {
        viewController?.displayLoadingView()
    }
}
