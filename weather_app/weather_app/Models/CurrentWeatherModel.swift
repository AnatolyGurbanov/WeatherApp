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
    let dt: Double?
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
    let sunrise: Double?
    let sunset: Double?
}

// MARK: - Weather
struct Weather: Decodable {

    let id: Int?
    let main: Main?
    let description: String?
    let icon: Icon?
}

enum Main: String, Decodable {

    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case thunderStorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case snow = "Snow"
    case mist = "Mist"
}

enum Icon: String, Decodable {

    case the01D = "01d"
    case the01N = "01n"
    case the02D = "02d"
    case the02N = "02n"
    case the03D = "03d"
    case the03N = "03n"
    case the04D = "04d"
    case the04N = "04n"
    case the09D = "09d"
    case the09N = "09n"
    case the10D = "10d"
    case the10N = "10n"
    case the11D = "11d"
    case the11N = "11n"
    case the13D = "13d"
    case the13N = "13n"
    case the50D = "50d"
    case the50N = "50n"
}

// MARK: - Wind
struct Wind: Decodable {

    let speed: Double?
    let deg: Float?
}
