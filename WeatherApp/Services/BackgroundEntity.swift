//
//  BackgroundEntity.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 12.10.2020.
//

import Foundation

struct BackgroundEntity: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let link: String
}
