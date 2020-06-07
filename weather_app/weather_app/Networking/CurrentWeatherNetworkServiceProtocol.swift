//
//  NetworkService.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrentWeatherNetworkServiceProtocol {
    func getCurrentWeatherData(for city: String?) -> Observable<CurrentWeatherModel>
}

extension CurrentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol {
    
    func getCurrentWeatherData(for city: String?) -> Observable<CurrentWeatherModel> {
        
        var currentWeatherQueryItems = [String: String]()
        currentWeatherQueryItems["q"] =  city ?? "Cupertino"
        currentWeatherQueryItems["lang"] = Language.russian
        currentWeatherQueryItems["units"] = Units.metric.rawValue
        currentWeatherQueryItems["appid"] = "718c08d192ca438ac00db7e22414c4d8"
        
        var requestPath: URL = URL(string: "www.google.com")!
        if let path = try? URLBuilder().buildUrl(host: APIURL.host,
                                         path: APIURL.weatherPath,
                                         queryItems: currentWeatherQueryItems) {
            requestPath = path
        }
        
        return rxNetworkService.request(path: requestPath, method: .get)
        
    }
}
