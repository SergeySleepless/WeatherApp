//
//  WeatherWorker.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 09.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher

class WeatherWorker {
    
    func fetchWeather(latitude: Double, longitude: Double, _ completion: @escaping(Result<WeatherEntity?, Error>) -> ()) {
        let parameters: Parameters = ["lat": latitude,
                                      "lon": longitude,
                                      "lang": "ru",
                                      "units": "metric",
                                      "appid": Constants.Weather.apiKey]
        NetworkService.shared.getWeatherData(url: Constants.Weather.weatherUrl, parameters: parameters) { (result) in
            switch result {
                case .success(let data):
                    guard let jsonData = data else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load"])
                        completion(.failure(error))
                        return
                    }
                    do {
                        let weather = try JSONDecoder().decode(WeatherEntity.self, from: jsonData)
                        completion(.success(weather))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func fetchBackgroundImage(for city: String, _ completion: @escaping(Result<BackgroundEntity?, Error>) -> ()) {
        let parameters: Parameters = ["q": "\(city) фото",
                                      "num": 1,
                                      "imgSize": "xxlarge",
                                      "imgType": "photo",
                                      "searchType": "image",
                                      "cx": "0f38f5e9535fea44b",
                                      "imgDominantColor": "black",
                                      "key": Constants.Background.apiKey]
        NetworkService.shared.getWeatherData(url: Constants.Background.url, parameters: parameters) { (result) in
            switch result {
                case .success(let data):
                    guard let jsonData = data else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load"])
                        completion(.failure(error))
                        return
                    }
                    do {
                        let background = try JSONDecoder().decode(BackgroundEntity.self, from: jsonData)
                        completion(.success(background))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func setImage(to imageView: UIImageView, urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imageView.kf.setImage(with: url)
    }
    
}
