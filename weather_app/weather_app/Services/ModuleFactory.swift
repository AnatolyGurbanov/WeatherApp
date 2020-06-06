//
//  ModuleFactory.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

public class ModuleFactory <T: UIViewController> {
    
    public let destination: T?
    public let handler: (() -> T)?
    
    public init(with viewController: T) {
        destination = viewController
        handler = nil
    }

    public init(with handler: @escaping () -> T) {
        self.handler = handler
        destination = handler()
    }

    public enum RoutingType {
        case push(_ from: PushModuleTransition)
        case present(_ from: PresentModuleTransition, wrapNC: UINavigationController.Type?)
        case forcePlaceRootOnWindow
    }
    
    public func produce(type: RoutingType,
                        completionHandler: (() -> Void)? = nil) {
        
        switch type {
        case .push(let source):

            var viewController = self.destination
            if let closure = handler {
                viewController = closure()
            }
            source.push(viewController, animated: true)
            
        case .present(let source, let navigationControllerType):
            
            guard let destination = destination else {
                return
            }
            
            var viewController = destination
            if let closure = handler {
                viewController = closure()
            }
            if let navigationControllerType = navigationControllerType {
                let navigationController = navigationControllerType.init(rootViewController: viewController)
                source.present(navigationController, animated: true)
                return
            }

            source.present(viewController, animated: true)
            
        case .forcePlaceRootOnWindow:
            
            guard let destination = self.destination else {
                return
            }

            var viewController = destination
            if let closure = handler {
                viewController = closure()
            }
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
        completionHandler?()
    }
}

extension ModuleFactory: Equatable where T: UIViewController {
    public static func == (lhs: ModuleFactory<T>, rhs: ModuleFactory<T>) -> Bool {
        return lhs.destination == rhs.destination
    }
}
