//
//  WeatherModels.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 09.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Weather {
    
    enum FetchWeather {
        
        struct Request {
        }
        
        struct Response {
            let weather: WeatherEntity
        }
        
        struct ViewModel {
            struct Header {
                let cityName: String
                let desc: String
                let temperature: String
                let temperatureMaxMin: String
            }
            struct WeatherByTime {
                let time: String
                let temperature: String
                let imageId: String
            }
            struct WeatherByDay {
                let dayName: String
                let imageId: String
                let temperatureMax: String
                let temperatureMin: String
            }
            struct WeatherInfo {
                enum Titles: String, CaseIterable {
                    case feelsLike = "ОЩУЩАЕТСЯ"
                    case pressure = "АТМОСФЕРНОЕ ДАВЛЕНИЕ"
                    case humidity = "ВЛАЖНОСТЬ"
                    case clouds = "ОБЛАЧНОСТЬ"
                    case windSpeed = "СКОРОСТЬ ВЕТРА"
                    case windDeg = "НАПРАВЛЕНИЕ ВЕТРА"
                    case visibility = "ВИДИМОСТЬ"
                }
                let feelsLike: String
                let pressure: String
                let humidity: String
                let clouds: String
                let windSpeed: String
                let windDeg: String
                let visibility: String
                
            }
            let header: Header
            let weatherByTimes: [WeatherByTime]
            let weatherByDays: [WeatherByDay]
            let weatherInfo: WeatherInfo
        }
        
    }
    
    enum FetchBackgroundImage {
        
        struct Response {
            let urlString: String
        }
        struct ViewModel {
            let urlString: String
        }
        
    }
    
    enum SetImage {
        
        struct Request {
            let imageView: UIImageView
            let urlString: String
        }
        
    }
    
}
