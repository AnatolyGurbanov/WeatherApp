//
//  ModuleFactory+Push.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

public protocol PushModuleTransition {
    func push(_ vc: UIViewController?, animated: Bool)
}

extension UIViewController: PushModuleTransition {
    
    public func push(_ vc: UIViewController?, animated: Bool) {
        
        guard let nc = self.navigationController else {
            assertionFailure("Navigation controller does not exist!")
            return
        }
        
        guard let destination = vc else {
            assertionFailure("Destination controller does not exist!")
            return
        }
        
        nc.pushViewController(destination, animated: animated)
    }
}
