//
//  SpacingCell.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

protocol ColorobleItem {
    var backgroundColor: UIColor { get set }
}

class SpacingCell: UITableViewCell, CellWithItem {
    
    @IBOutlet weak var space: NSLayoutConstraint!
    
    var cellItem: SpacingItem!
    
    func setItem(item: Any) {
        
        guard let item = item as? SpacingItem else {return}
        self.cellItem = item
        self.space.constant = self.cellItem.space
        self.backgroundColor = self.cellItem.backgroundColor
    }
}

class SpacingItem: NSObject, ColorobleItem, ItemProtocol {
    
    var space: CGFloat
    var backgroundColor: UIColor
    var reuseIdentifier: String {
        return SpacingCell.className
    }
    
    init(space: CGFloat, backgroundColor: UIColor = .clear) {
        
        self.space = space
        self.backgroundColor = backgroundColor
    }
}
