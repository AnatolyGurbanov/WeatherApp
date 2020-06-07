//
//  APIHelper.swift
//  weather_app
//
//  Created by Anatoly on 05.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

public struct APIURL {

    static let host = "api.openweathermap.org"
    static let weatherPath = "/data/2.5/weather"
    static let dailyForecastPath = "/data/2.5/forecast/daily"
}

public struct Language {

    static let english = "en"
    static let russian = "ru"
}

public enum Units: String {

    case metric
    case imperial
}
