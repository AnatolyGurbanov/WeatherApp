//
//  WeatherDescriptionTableViewCell.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

class WeatherDescriptionTableViewCell: UITableViewCell, CellWithItem {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func setItem(item: Any) {
        
        guard let item = item as? WeatherDescriptionItem else { return }

        titleLabel.text = item.title
        valueLabel.text = item.value
    }
    
}

class WeatherDescriptionItem: NSObject, ItemProtocol {
    
    var title: String?
    var value: String?
    
    var reuseIdentifier: String {
        return WeatherDescriptionTableViewCell.className
    }
    
    init(title: String? = nil, value: String? = nil) {

        self.title = title
        self.value = value
    }

}
