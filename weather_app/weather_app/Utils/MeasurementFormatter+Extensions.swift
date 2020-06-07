//
//  MeasurementFormatter+Extensions.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

extension MeasurementFormatter {

    public static var temperatureFormatter: MeasurementFormatter {

        let tempFortmatter = MeasurementFormatter()
        tempFortmatter.unitOptions = .providedUnit
        tempFortmatter.unitStyle = .medium
        tempFortmatter.numberFormatter.maximumFractionDigits = 0
        
        return tempFortmatter
    }
    
}
