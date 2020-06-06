//
//  ApplicationAssembler.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation
import Swinject

struct ApplicationAssembler {

    private static func allAssemblies() -> [Assembly] {

        var result: [Assembly] = []

        result += [CurrentWeatherModuleContainer()]

        return result
    }

    static let shared = Assembler(allAssemblies())

    static func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return shared.resolver.resolve(serviceType)
    }
}
