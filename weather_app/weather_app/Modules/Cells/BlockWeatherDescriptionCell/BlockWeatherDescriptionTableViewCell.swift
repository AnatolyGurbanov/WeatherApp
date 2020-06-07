//
//  BlockWeatherDescriptionTableViewCell.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

class BlockWeatherDescriptionTableViewCell: UITableViewCell, CellWithItem {

    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstValueLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var secondValueLabel: UILabel!
    
    func setItem(item: Any) {

        guard let item = item as? BlockWeatherDescriptionItem else { return }

        firstTitleLabel.text = item.firstTitle
        firstValueLabel.text = item.firstValue
        secondTitleLabel.text = item.secondTitle
        secondValueLabel.text = item.secondValue
    }
    
}

class BlockWeatherDescriptionItem: NSObject, ItemProtocol {
    
    var firstTitle: String?
    var firstValue: String?
    var secondTitle: String?
    var secondValue: String?

    var reuseIdentifier: String {
        return BlockWeatherDescriptionTableViewCell.className
    }
    
    init(firstTitle: String? = nil, firstValue: String? = nil, secondTitle: String? = nil, secondValue: String? = nil) {

        self.firstTitle = firstTitle
        self.firstValue = firstValue
        self.secondTitle = secondTitle
        self.secondValue = secondValue
    }
    
}
