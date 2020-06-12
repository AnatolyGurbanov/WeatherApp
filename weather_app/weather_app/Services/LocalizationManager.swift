//
//  LocalizationManager.swift
//  weather_app
//
//  Created by Anatoly on 08.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

class LocalizationManager {

    static let shared = LocalizationManager()

    private init() { }

    func getPreferredLocale() -> Locale {

        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }

        return Locale(identifier: preferredIdentifier)
    }
}
