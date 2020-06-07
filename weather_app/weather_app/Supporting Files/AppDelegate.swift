//
//  AppDelegate.swift
//  weather_app
//
//  Created by Anatoly on 05.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var assembler = ApplicationAssembler.shared
    var currenWeatherModuleFactory: ModuleFactory<CurrentWeatherViewController>!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        installInitialModule()
        
        let design = Design()
        design.apply()
        return true
    }
    
    private func installInitialModule() {
        
        window = UIWindow()
        
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        currenWeatherModuleFactory = ModuleFactory(with: assembler.resolver.resolve(CurrentWeatherViewController.self)!)
        currenWeatherModuleFactory.produce(type: .forcePlaceRootOnWindow)
    }


}

