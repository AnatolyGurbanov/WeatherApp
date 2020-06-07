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
        
        var items: [ItemProtocol] = []

        if let temperature = model.main?.temp, let weatherDescription = model.weather?.first?.weatherDescription {
            
            let tempMeasurement = Measurement(value: temperature, unit: UnitTemperature.celsius)
            let headerItem = HeaderItem(cityName: model.name,
                                        weatherDescription: weatherDescription,
                                        currentTemp: MeasurementFormatter.temperatureFormatter.string(from: tempMeasurement))
            items.append(headerItem)
            items.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let minTemp = model.main?.tempMin, let maxTemp = model.main?.tempMax {
            
            let tempMinMeasurement = Measurement(value: minTemp, unit: UnitTemperature.celsius)
            let tempMaxMeasurement = Measurement(value: maxTemp, unit: UnitTemperature.celsius)
            
            let minMaxTempItem = BlockWeatherDescriptionItem(firstTitle: "Минимальная температура",
                                                             firstValue: MeasurementFormatter.temperatureFormatter.string(from: tempMinMeasurement),
                                                             secondTitle: "Максимальная температура",
                                                             secondValue: MeasurementFormatter.temperatureFormatter.string(from: tempMaxMeasurement))
            items.append(minMaxTempItem)
            items.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let windSpeed = model.wind?.speed, let windDirection = model.wind?.deg {
            
            let speedMeasurement = Measurement(value: windSpeed, unit: UnitSpeed.metersPerSecond)
            
            let windItem = BlockWeatherDescriptionItem(firstTitle: "Скорость ветра",
                                                       firstValue: MeasurementFormatter.speedFormatter.string(from: speedMeasurement),
                secondTitle: "Направление ветра",
                secondValue: "\(windDirection)")
            
            items.append(windItem)
            items.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let pressure = model.main?.pressure {
            
            let measurement = Measurement(value: (pressure / 1.333), unit: UnitPressure.millimetersOfMercury)
            let pressureItem = WeatherDescriptionItem(title: "Давление",
                                                      value: MeasurementFormatter.pressureFormatter.string(from: measurement))
            items.append(pressureItem)
            items.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let humidity = model.main?.humidity as NSNumber? {
            
            let humidityItem = WeatherDescriptionItem(title: "Влажность",
                                                      value: NumberFormatter.percentageFormatter.string(from: humidity))
            items.append(humidityItem)
            items.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let clouds = model.clouds?.all as NSNumber? {

            let humidityItem = WeatherDescriptionItem(title: "Облачность",
                                                      value: NumberFormatter.percentageFormatter.string(from: clouds))
            items.append(humidityItem)
            items.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        self.items.onNext(items)
        
    }
    
    func buildRows() {

        let cachedCity = UserDefaults.standard.string(forKey: "city")
        
        self.getWeather(city: cachedCity)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (weather) in
                guard let self = self else { return }
                UserDefaults.standard.set(weather.name, forKey: "city")
                self.buildRowItems(by: weather)
            })
            .disposed(by: bag)
        
    }
    
    func getWeather(city: String?) -> Observable<CurrentWeather> {
        
        return self.networkService.getCurrentWeatherData(for: city)
    }
}
