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
    
    func setItem(item: Any) {
        
        guard let item = item as? SpacingItem else {return}
        space.constant = item.space
        backgroundColor = item.backgroundColor
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
