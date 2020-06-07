//
//  CurrentWeatherViewModel.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation
import RxSwift

class CurrentWeatherViewModel: NSObject {
    
    private let bag = DisposeBag()

    var networkService: CurrentWeatherNetworkServiceProtocol!
    var items = BehaviorSubject<[ItemProtocol]?>(value: nil)
    var currentWeather: CurrentWeather? = nil
    
    func buildRowItems(by model: CurrentWeather) {
        
        let tempMeasurement = Measurement(value: (model.main?.temp)!, unit: UnitTemperature.celsius)

        let headerItem = HeaderItem(cityName: model.name,
                                    weatherDescription: model.weather?.first?.weatherDescription,
                                    currentTemp: MeasurementFormatter.tempratureFormatter.string(from: tempMeasurement))

        let measurement = Measurement(value: ((model.main?.pressure)! / 1.333), unit: UnitPressure.millimetersOfMercury)
        
        let pressureItem = WeatherDescriptionItem(title: "Давление",
                                                  value: MeasurementFormatter.pressureFormatter.string(from: measurement))
        
        
        let humidityItem = WeatherDescriptionItem(title: "Влажность",
                                                  value: NumberFormatter.percentageFormatter.string(from: NSNumber(value: (model.main?.humidity)!)))
        
        let cloudsItem = WeatherDescriptionItem(title: "Облачность",
                                                value: NumberFormatter.percentageFormatter.string(from: NSNumber(value: (model.clouds?.all)!)))

        let items: [ItemProtocol] = [headerItem,
                                     SpacingItem(space: 1, backgroundColor: .lightGray),
                                     pressureItem,
                                     SpacingItem(space: 1, backgroundColor: .lightGray),
                                     humidityItem,
                                     SpacingItem(space: 1, backgroundColor: .lightGray),
                                     cloudsItem]
        
        self.items.onNext(items)
        
    }
    
    func buildRows() {
        
        self.getWeather(city: "Новосибирск")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (weather) in
                guard let self = self else { return }
                self.buildRowItems(by: weather)
            })
            .disposed(by: bag)
        
    }
    
    func getWeather(city: String?) -> Observable<CurrentWeather> {
        
        return self.networkService.getCurrentWeatherData(for: city)
    }
}
