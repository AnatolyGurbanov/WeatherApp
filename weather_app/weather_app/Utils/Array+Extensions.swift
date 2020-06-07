//
//  Array+Extensions.swift
//  weather_app
//
//  Created by Anatoly on 08.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    func withRemovedDuplicates() -> [Element] {
        return self.reduce(into: [], { if !$0.contains($1) { $0 += [$1] } })
    }
}
