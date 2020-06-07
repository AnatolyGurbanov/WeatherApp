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
    var dataSource: BaseDataSource!
    @IBOutlet var rootView: CurrentWeatherView!
    
    override func viewDidLoad() {
        
        dataSource = BaseDataSource(tableView: rootView.tableView)
        
        self.viewModel.items.subscribe(onNext: { [weak self] (items) in
            guard let self = self,
            let rows = items else { return }

            self.dataSource.items = rows
        }).disposed(by: bag)
        
        self.viewModel.buildRows()
        
    }
    
}
