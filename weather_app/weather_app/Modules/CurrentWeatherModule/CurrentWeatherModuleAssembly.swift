//
//  CurrentWeatherModuleAssembly.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation
import Swinject

class CurrentWeatherModuleContainer: Assembly {

    func assemble(container: Container) {
        
        container.register(ModuleFactory<CurrentWeatherViewController>.self,
                           name: "CurrentWeatherViewController") { resolver in

            return ModuleFactory<CurrentWeatherViewController>(with: {
                return resolver.resolve(CurrentWeatherViewController.self)!
            })
        }
        
        container.register(CurrentWeatherViewController.self) { resolver in
            
            let controller: CurrentWeatherViewController = .fromStoryboard()
            controller.viewModel = resolver.resolve(CurrentWeatherViewModel.self)
            return controller
            
        }.inObjectScope(.weak)
        
        container.register(CurrentWeatherNetworkService.self) { resolver in

            let networkService = CurrentWeatherNetworkService()
            networkService.rxNetworkService = WeatherServicesContainer.instance.resolve(RxNetworkService.self)!
            
            return networkService

        }.inObjectScope(.weak)
        
        container.register(CurrentWeatherViewModel.self) { resolver in
            
            let viewModel = CurrentWeatherViewModel()
            viewModel.networkService = resolver.resolve(CurrentWeatherNetworkService.self)
            return viewModel
            
        }.inObjectScope(.weak)
    }
    
}
