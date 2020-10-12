//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 09.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherBusinessLogic {
    func requestWeather(request: Weather.FetchWeather.Request)
    func requestLocation()
    func setImage(request: Weather.SetImage.Request)
}

protocol WeatherDataStore {
    var weather: WeatherEntity? { get }
}

class WeatherInteractor: NSObject, WeatherDataStore {
    
    var presenter: WeatherPresentationLogic?
    var worker: WeatherWorker?
    
    var weather: WeatherEntity?
    private let locationManager = CLLocationManager()
    
    private func handleWeather(_ response: Result<WeatherEntity?, Error>) {
        switch response {
            case .success(let weather):
                if let weather = weather {
                    self.weather = weather
                    presenter?.presentWeather(response: .init(weather: weather))
                    self.loadBackground()
                }
            case .failure(let error):
                print(error)
        }
    }
    
    private func handleBackground(_ response: Result<BackgroundEntity?, Error>) {
        switch response {
            case .success(let backgroundResponse):
                if let backgroundResponse = backgroundResponse {
                    if let link = backgroundResponse.items.first {
                        self.presenter?.presentBackgroundImageUrl(response: .init(urlString: link.link))
                    }
                }
            case .failure(let error):
                print(error)
        }
    }
    
    private func loadBackground() {
        guard let weather = weather else { return }
        worker?.fetchBackgroundImage(for: weather.city.name, { (result) in
            self.handleBackground(result)
        })
    }
    
    private func getCurrentLocation()  {
        presenter?.presentLoadingView()
        locationManager.startUpdatingLocation()
        if let location = locationManager.location {
            worker = WeatherWorker()
            worker?.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { [weak self] (response) in
                self?.handleWeather(response)
            }
        }
    }
    
}

extension WeatherInteractor: WeatherBusinessLogic {
    func setImage(request: Weather.SetImage.Request) {
        worker = WeatherWorker()
        worker?.setImage(to: request.imageView, urlString: request.urlString)
    }
    
    func requestWeather(request: Weather.FetchWeather.Request) {
        guard let coordinate = locationManager.location?.coordinate else { return }
        worker = WeatherWorker()
        worker?.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] (response) in
            self?.handleWeather(response)
        }
    }
    
    func requestLocation() {
        locationManager.delegate = self
        let status = locationManager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            getCurrentLocation()
        } else if status == .denied {
            presenter?.presentNeedsPermissionView()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension WeatherInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            getCurrentLocation()
        } else if status != .notDetermined {
            presenter?.presentNeedsPermissionView()
        }
    }
}
