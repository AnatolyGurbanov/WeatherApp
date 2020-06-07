//
//  Array+Extensions.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
