//
//  CurrentWeatherViewController.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit
import RxSwift
import CoreLocation

class CurrentWeatherViewController: UIViewController {
    
    private let bag = DisposeBag()

    var viewModel: CurrentWeatherViewModel!
    private var locationManager = CLLocationManager()
    private var dataSource: BaseDataSource!
    @IBOutlet var rootView: CurrentWeatherView!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        
        rootView.decorate()

        viewModel.items.subscribe(onNext: { [weak self] (items) in
            guard let self = self,
                let rows = items else { return }
            self.dataSource.items = rows
        }).disposed(by: bag)

        locationManager.requestWhenInUseAuthorization()
        configureWeatherTableView()
        configureRefreshControl()
        setUpNavigatiionBar()
    }
    
    private func configureWeatherTableView() {

        dataSource = BaseDataSource(tableView: rootView.tableView)
        viewModel.buildRows(cityName: DiskCache().requestCity())
    }
    
    private func configureRefreshControl() {
        
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        rootView.tableView.refreshControl = refreshControl
    }
    
    @objc
    private func refreshData(sender: UIRefreshControl) {

        viewModel.buildRows(cityName: DiskCache().requestCity())
        sender.endRefreshing()
    }
    
    private func setUpNavigatiionBar() {

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        let addCityButton = UIBarButtonItem(image: .cityButtonIcon,
                                        style: .plain,
                                        target: self,
                                        action: #selector(showNewCityInfo))
        addCityButton.tintColor = .white
        navigationItem.rightBarButtonItem = addCityButton
        
        let locationButton = UIBarButtonItem(image: .locationButtonIcon,
                                        style: .plain,
                                        target: self,
                                        action: #selector(getCityInfoWithLocation))
        locationButton.tintColor = .white
        navigationItem.leftBarButtonItem = locationButton
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
    
    @objc
    private func getCityInfoWithLocation() {

        var currentLoc: CLLocation!
        let locationStatus = CLLocationManager.authorizationStatus()

        switch locationStatus {
        case .authorizedWhenInUse:

            currentLoc = locationManager.location
            viewModel.getWeather(latitude: currentLoc.coordinate.latitude.description,
                                 longitude: currentLoc.coordinate.latitude.description)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            showStatusDeniedAlert()
        }
        
    }
    
    private func showStatusDeniedAlert() {

        let alertController = UIAlertController(title: "Отсутсвует доступ к геолокации",
                                                message: "Для показа информации о погоде по геолокации необходимо открыть настройки приложения и включить доступ к геопозиции.",
                                                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Открыть настройки", style: .`default`, handler: { action in
            
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }))
        present(alertController, animated: true)
    }
    
}
