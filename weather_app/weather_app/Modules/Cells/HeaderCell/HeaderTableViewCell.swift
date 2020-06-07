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

    var cellItem: HeaderItem!
    
    func setItem(item: Any) {

        guard let item = item as? HeaderItem else { return }
        self.cellItem = item
        self.cityNameLabel.text = self.cellItem.cityName
        self.weatherDescriptionLabel.text = self.cellItem.weatherDescription
        self.tempratureLabel.text = self.cellItem.currentTemp
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
