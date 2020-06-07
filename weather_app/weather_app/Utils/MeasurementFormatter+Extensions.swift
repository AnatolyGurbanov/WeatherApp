//
//  MeasurementFormatter+Extensions.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

extension MeasurementFormatter {
    
    
    public static var tempratureFormatter: MeasurementFormatter {

        let tempFortmatter = MeasurementFormatter()
        tempFortmatter.unitOptions = .providedUnit
        tempFortmatter.unitStyle = .short
        tempFortmatter.locale = Locale(identifier: "ru_RU")
        
        return tempFortmatter
    }

    public static var pressureFormatter: MeasurementFormatter {

        let pressureFormatter = MeasurementFormatter()
        pressureFormatter.unitOptions = .providedUnit
        pressureFormatter.unitStyle = .medium
        pressureFormatter.locale = Locale(identifier: "ru_RU")
        
        return pressureFormatter
    }
    
}
