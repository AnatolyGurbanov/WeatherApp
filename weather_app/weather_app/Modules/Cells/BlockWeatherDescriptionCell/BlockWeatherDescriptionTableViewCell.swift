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

    var cellItem: BlockWeatherDescriptionItem!
    
    func setItem(item: Any) {

        guard let item = item as? BlockWeatherDescriptionItem else { return }
        self.cellItem = item
        self.firstTitleLabel.text = self.cellItem.firstTitle
        self.firstValueLabel.text = self.cellItem.firstValue
        self.secondTitleLabel.text = self.cellItem.secondTitle
        self.secondValueLabel.text = self.cellItem.secondValue
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
