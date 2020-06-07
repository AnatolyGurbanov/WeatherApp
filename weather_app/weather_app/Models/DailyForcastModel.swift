//
//  DailyForcastModel.swift
//  weather_app
//
//  Created by Anatoly on 05.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

// MARK: - DailyForcast
struct DailyForcastModel: Decodable {

    let cod: String?
    let message: Int?
    let city: City?
    let cnt: Int?
    let list: [List]?
}

// MARK: - City
struct City: Decodable {

    let geonameID: Int?
    let name: String?
    let lat: Double?
    let lon: Double?
    let country: String?
    let iso2: String?
    let type: String?
    let population: Int?
}

// MARK: - List
struct List: Decodable {

    let dt: Int?
    let temp: Temp?
    let pressure: Double?
    let humidity: Int?
    let weather: [Weather]?
    let speed: Double?
    let deg: Int?
    let clouds: Int?
    let rain: Double?
    let snow: Double?
}

// MARK: - Temp
struct Temp: Decodable {

    let day: Double?
    let eve: Double?
    let morn: Double?
    let night: Double?
}

enum Description: String, Decodable {

    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case skyIsClear = "sky is clear"
}
