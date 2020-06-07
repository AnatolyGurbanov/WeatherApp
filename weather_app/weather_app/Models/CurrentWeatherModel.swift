//
//  CurrentWeatherModel.swift
//  weather_app
//
//  Created by Anatoly on 05.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

// MARK: - CurrentWeather
struct CurrentWeatherModel: Decodable {

    let coord: Coordinates?
    let weather: [Weather]?
    let base: String?
    let main: MainInfo?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: TimeInterval?
    let sys: InternalParameters?
    let id: Int?
    let timezone: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int?
}

// MARK: - Coordinates
struct Coordinates: Decodable {
    let lon: Double?
    let lat: Double?
}

// MARK: - Main
struct MainInfo: Decodable {

    let temp: Double?
    let pressure: Double?
    let humidity: Int?
    let tempMin: Double?
    let tempMax: Double?
}

// MARK: - Internal Parameters
struct InternalParameters: Decodable {

    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: TimeInterval?
    let sunset: TimeInterval?
}

// MARK: - Weather
struct Weather: Decodable {

    let id: Int?
    let description: String?
}

// MARK: - Wind
struct Wind: Decodable {

    let speed: Double?
    let deg: Float?
}
