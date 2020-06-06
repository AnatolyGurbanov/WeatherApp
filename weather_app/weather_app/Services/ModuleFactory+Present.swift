//
//  ModuleFactory+Present.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

public protocol PresentModuleTransition {
    func present(_ vc: UIViewController?, animated: Bool)
}

extension UIViewController: PresentModuleTransition {
    
    public func present(_ vc: UIViewController?, animated: Bool) {
        
        guard let destination = vc else {
            assertionFailure("Destination controller does not exist!")
            return
        }
        
        var target: UIViewController
        if let navigation = self.navigationController {
            target = navigation
        } else {
            target = self
        }
        
        target.present(destination, animated: animated, completion: nil)
    }
}
