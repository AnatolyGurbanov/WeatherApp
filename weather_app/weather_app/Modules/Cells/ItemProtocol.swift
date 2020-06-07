//
//  CellItemProtocol.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

protocol ItemProtocol: NSObject {

    var reuseIdentifier: String { get }
    var itemHeight: CGFloat { get }
}

extension ItemProtocol {

    var itemHeight: CGFloat {
        return UITableView.automaticDimension
    }
}
