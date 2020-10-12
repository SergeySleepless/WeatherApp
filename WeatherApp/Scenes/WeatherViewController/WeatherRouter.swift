//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 09.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol WeatherRoutingLogic {
    
}

protocol WeatherDataPassing {
    var dataStore: WeatherDataStore? { get }
}

class WeatherRouter: NSObject {
    
    weak var viewController: WeatherViewController?
    var dataStore: WeatherDataStore?
    
    // MARK: Navigation
    
}

// MARK: Routing

extension WeatherRouter: WeatherRoutingLogic {
    
}

// MARK: Passing data

extension WeatherRouter: WeatherDataPassing {
    
}
