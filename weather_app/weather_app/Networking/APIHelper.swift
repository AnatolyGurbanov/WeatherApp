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

    static let afrikaans = "af"
    static let arabic = "ar"
    static let azerbaijani = "az"
    static let bulgarian = "bg"
    static let catalan = "ca"
    static let czech = "cz"
    static let danish = "da"
    static let german = "de"
    static let greek = "el"
    static let english = "en"
    static let basque = "eu"
    static let persian = "fa"
    static let finnish = "fi"
    static let french = "fr"
    static let galician = "gl"
    static let hebrew = "he"
    static let hindi = "hi"
    static let croatian = "hr"
    static let hungarian = "hu"
    static let indonesian = "id"
    static let italian = "it"
    static let japanese = "ja"
    static let korean = "kr"
    static let latvian = "la"
    static let lithuanian = "lt"
    static let macedonian = "mk"
    static let norwegian = "no"
    static let dutch = "nl"
    static let polish = "pl"
    static let portuguese = "pt"
    static let portugueseBrasil = "pt_br"
    static let romanian = "ro"
    static let russian = "ru"
    static let swedish = "sv"
    static let slovak = "sk"
    static let slovenian = "sl"
    static let spanish = "es"
    static let serbian = "sr"
    static let thai = "th"
    static let turkish = "tr"
    static let ukrainian = "ua"
    static let vietnamese = "vi"
    static let chineseSimplified = "zh_cn"
    static let chineseTraditional = "zh_tw"
    static let zulu = "zu"
}

public enum Units: String {

    case metric
    case imperial
}
