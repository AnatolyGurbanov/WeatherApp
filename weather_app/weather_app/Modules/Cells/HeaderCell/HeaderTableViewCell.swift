//
//  HeaderTableViewCell.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell, CellWithItem {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    
    func setItem(item: Any) {

        guard let item = item as? HeaderItem else { return }
        self.cityNameLabel.text = item.cityName
        self.weatherDescriptionLabel.text = item.weatherDescription
        self.tempratureLabel.text = item.currentTemp
    }
    
}

class HeaderItem: NSObject, ItemProtocol {
    
    var cityName: String?
    var weatherDescription: String?
    var currentTemp: String?
    
    var reuseIdentifier: String {
        return HeaderTableViewCell.className
    }

    init(cityName: String? = nil, weatherDescription: String? = nil, currentTemp: String? = nil) {

        self.cityName = cityName
        self.weatherDescription = weatherDescription
        self.currentTemp = currentTemp
    }
    
}
