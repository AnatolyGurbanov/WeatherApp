//
//  UIViewComntroller+Stroyboard.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func fromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        
        for bundle in [Bundle.main] + Bundle.allFrameworks {
            
            guard let _ = bundle.path(forResource: name, ofType: "storyboardc") else {
                continue
            }
            
            let storyboard = UIStoryboard(name: name, bundle: bundle)
            if let viewController = storyboard.instantiateInitialViewController() as? T {
                return viewController
            }
        }

        fatalError("Failed to create viewController from storyboard \(name)")
    }
}
