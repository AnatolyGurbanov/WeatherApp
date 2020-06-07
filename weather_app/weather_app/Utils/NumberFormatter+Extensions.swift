//
//  NumberFormatter+Extensions.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

extension NumberFormatter {

    public static var percentageFormatter: NumberFormatter {
        
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.multiplier = 1
        percentFormatter.maximumFractionDigits = 0
        
        return percentFormatter
    }
}
