//
//  CellWithItemProtocol.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

protocol CellWithItem: UITableViewCell {
    func setItem(item: Any)
}
