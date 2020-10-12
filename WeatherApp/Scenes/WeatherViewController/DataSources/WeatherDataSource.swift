//
//  WeatherDataSource.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 12.10.2020.
//

import UIKit

class WeatherDataSource: NSObject {
    
    private var viewModel: Weather.FetchWeather.ViewModel
    private var weathersByDaysDataSource: WeathersByDaysDataSource
    var weathersByTimeDataSource: WeathersByTimeDataSource
    private var weatherInfoDataSource: WeatherInfoDataSource
    
    init(viewModel: Weather.FetchWeather.ViewModel, delegate: SetImageDelegate) {
        self.viewModel = viewModel
        self.weathersByDaysDataSource = .init(weatherByDays: viewModel.weatherByDays, delegate: delegate)
        self.weathersByTimeDataSource = .init(weathersByTime: viewModel.weatherByTimes, delegate: delegate)
        self.weatherInfoDataSource = .init(weatherInfo: viewModel.weatherInfo)
    }
    
    private func createWeatherHeader(_ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHeaderCell.identifier) as! WeatherHeaderCell
        cell.setupViews()
        cell.cityNameLabel.text = viewModel.header.cityName
        cell.descriptionLabel.text = viewModel.header.desc
        cell.temperatureLabel.text = viewModel.header.temperature
        cell.temperatureMaxMinLabel.text = viewModel.header.temperatureMaxMin
        return cell
    }
    
    private func createWeatherByTime(_ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeathersByTimesCell.identifier) as! WeathersByTimesCell
        cell.setupView(dataSource: weathersByTimeDataSource)
        return cell
    }
    
    private func createWeatherByDays(_ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeathersByDaysCell.identifier) as! WeathersByDaysCell
        cell.setupView(dataSource: weathersByDaysDataSource)
        return cell
    }
    
    private func createWeatherInfo(_ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInfosCell.identifier) as! WeatherInfosCell
        cell.setupView(dataSource: weatherInfoDataSource)
        return cell
    }
    
}

extension WeatherDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0:
                return UITableView.automaticDimension
            case 1:
                return 130
            case 2:
                return CGFloat(weathersByDaysDataSource.weatherByDays.count * 30)
            case 3:
                return 7 * 50
            default:
                return UITableView.automaticDimension
        }
    }
}

extension WeatherDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                return createWeatherHeader(tableView)
            case 1:
                return createWeatherByTime(tableView)
            case 2:
                return createWeatherByDays(tableView)
            case 3:
                return createWeatherInfo(tableView)
            default:
                return UITableViewCell()
        }
    }
}
