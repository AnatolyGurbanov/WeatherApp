//
//  CurrentWeatherViewController.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit
import RxSwift

class CurrentWeatherViewController: UIViewController {
    
    private let bag = DisposeBag()
    var viewModel: CurrentWeatherViewModel!
    
    override func viewDidLoad() {

        self.viewModel.getWeather(city: "Cupertino")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (weather) in
                guard let self = self else { return }
                print("weather is getted")
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                print("error")
            }, onCompleted: {
                print("Completed")
            })
            .disposed(by: bag)
    }
    
}
