//
//  CurrentWeatherView.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    func decorate() {
        self.backgroundColor = UIColor(red: 0.29, green: 0.60, blue: 0.52, alpha: 1.00)
    }
}
