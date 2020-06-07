//
//  WeatherServicesContainer.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation
import Swinject

class WeatherServicesContainer {

    public static let instance = Container(defaultObjectScope: .container) { (container) in
        
        registerNetworkService(with: container)
    }
    
    private static func registerNetworkService(with container: Container) {
        
        container.register(RxNetworkService.self) { r in
            
            let service = RxNetworkService()
            return service
            
            }.inObjectScope(.container)
    }

}
