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
    private var dataSource: BaseDataSource!
    @IBOutlet var rootView: CurrentWeatherView!
    
    let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        
        dataSource = BaseDataSource(tableView: rootView.tableView)
        rootView.tableView.refreshControl = refreshControl
        
        viewModel.items.subscribe(onNext: { [weak self] (items) in
            guard let self = self,
            let rows = items else { return }

            self.dataSource.items = rows
        }).disposed(by: bag)
        
        let cachedCity = UserDefaults.standard.string(forKey: "city")
        viewModel.buildRows(cityName: cachedCity)
        
        setUpNavigatiionBar()
        
    }
    
    @objc
    private func refreshData(sender: UIRefreshControl) {
        let cachedCity = UserDefaults.standard.string(forKey: "city")
        viewModel.buildRows(cityName: cachedCity)
        sender.endRefreshing()
    }
    
    private func setUpNavigatiionBar() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ГОРОД", style: .plain, target: self, action: #selector(showNewCityInfo))
    }
    
    @objc
    private func showNewCityInfo() {
        
        let alertController = UIAlertController(title: "Город", message: "Введите название города", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)

        let confirmAction = UIAlertAction(title: "Подтвердить", style: .default) { [weak self] (action) in

            if let textField = alertController.textFields?.first {
                self?.viewModel.buildRows(cityName: textField.text)
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)

        alertController.addTextField { (textField) in
            textField.placeholder = "Название города"
        }
        
        present(alertController, animated: true)
        
    }
    
}
