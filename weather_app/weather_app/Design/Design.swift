//
//  Design.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

struct Design {

    func apply() {
        applyCommonDesign()
    }
}

private extension Design {

    func applyCommonDesign() {

        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().tintColor = .gray
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}
