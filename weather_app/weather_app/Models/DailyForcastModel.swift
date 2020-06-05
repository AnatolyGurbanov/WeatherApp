//
//  DailyForcastModel.swift
//  weather_app
//
//  Created by Anatoly on 05.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

// MARK: - DailyForcast
struct DailyForcast: Codable {

    let cod: String?
    let message: Int?
    let city: City?
    let cnt: Int?
    let list: [List]?
}

// MARK: - City
struct City: Codable {

    let geonameID: Int?
    let name: String?
    let lat, lon: Double?
    let country, iso2, type: String?
    let population: Int?

    enum CodingKeys: String, CodingKey {
        case geonameID = "geoname_id"
        case name, lat, lon, country, iso2, type, population
    }
}

// MARK: - List
struct List: Codable {

    let dt: Int?
    let temp: Temp?
    let pressure: Double?
    let humidity: Int?
    let weather: [Weather]?
    let speed: Double?
    let deg, clouds: Int?
    let rain, snow: Double?
}

// MARK: - Temp
struct Temp: Codable {
    let day, eve, morn, night: Double?
}

enum Description: String, Codable {

    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case skyIsClear = "sky is clear"
}
