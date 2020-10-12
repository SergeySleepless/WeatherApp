//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 09.10.2020.
//

import Foundation
import Alamofire

class NetworkService {
    
    private init() {}
    
    static let shared = NetworkService()
    
    public func getWeatherData(url: String, parameters: Parameters, completion: @escaping(Result<Data?, Error>) -> ()) {
        AF.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
}

enum WeatherResponse {
    case weather(WeatherEntity)
    case error(String)
}
