//
//  CurrentWeatherViewModel.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation
import RxSwift

class CurrentWeatherViewModel: NSObject {
    
    var networkService: CurrentWeatherNetworkServiceProtocol!
    
    func getWeather(city: String?) -> Observable<CurrentWeather> {
        
        return self.networkService.getCurrentWeatherData(for: city)
    }
}
