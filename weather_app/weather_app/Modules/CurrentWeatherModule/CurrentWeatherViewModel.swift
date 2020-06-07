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
    private var currentWeather: CurrentWeatherModel? = nil
    
    private func buildRowItems(by model: CurrentWeatherModel) {
        
        var cellItems: [ItemProtocol] = []

        if let temperature = model.main?.temp, let weatherDescription = model.weather?.first?.description {
            
            let tempMeasurement = Measurement(value: temperature, unit: UnitTemperature.celsius)
            let headerItem = HeaderItem(cityName: model.name,
                                        weatherDescription: weatherDescription,
                                        currentTemp: MeasurementFormatter.temperatureFormatter.string(from: tempMeasurement))
            cellItems.append(headerItem)
            cellItems.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let sunrise = model.sys?.sunrise, let sunset = model.sys?.sunset, let timezone = model.timezone {
            
            let sunTimeItem = BlockWeatherDescriptionItem(firstTitle: "Восход солнца",
                                                          firstValue: dateFormat(by: sunrise, with: timezone),
                                                          secondTitle: "Закат солнца",
                                                          secondValue: dateFormat(by: sunset, with: timezone))
            
            cellItems.append(sunTimeItem)
            cellItems.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let minTemp = model.main?.tempMin, let maxTemp = model.main?.tempMax {
            
            let tempMinMeasurement = Measurement(value: minTemp, unit: UnitTemperature.celsius)
            let tempMaxMeasurement = Measurement(value: maxTemp, unit: UnitTemperature.celsius)
            
            let minMaxTempItem = BlockWeatherDescriptionItem(firstTitle: "Минимальная температура",
                                                             firstValue: MeasurementFormatter.temperatureFormatter.string(from: tempMinMeasurement),
                                                             secondTitle: "Максимальная температура",
                                                             secondValue: MeasurementFormatter.temperatureFormatter.string(from: tempMaxMeasurement))
            cellItems.append(minMaxTempItem)
            cellItems.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let windSpeed = model.wind?.speed, let windDirection = model.wind?.deg {
            
            let speedMeasurement = Measurement(value: windSpeed, unit: UnitSpeed.metersPerSecond)
            
            let windItem = BlockWeatherDescriptionItem(firstTitle: "Скорость ветра",
                                                       firstValue: MeasurementFormatter.speedFormatter.string(from: speedMeasurement),
                                                       secondTitle: "Направление ветра",
                                                       secondValue: windDirectionFromDegrees(degrees: windDirection))
            
            cellItems.append(windItem)
            cellItems.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let pressure = model.main?.pressure {
            
            let pressureValue = convertPressure(from: pressure, with: "ru_RU")
            let pressureItem = WeatherDescriptionItem(title: "Давление",
                                                      value: pressureValue)
            cellItems.append(pressureItem)
            cellItems.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let humidity = model.main?.humidity as NSNumber? {
            
            let humidityItem = WeatherDescriptionItem(title: "Влажность",
                                                      value: NumberFormatter.percentageFormatter.string(from: humidity))
            cellItems.append(humidityItem)
            cellItems.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let clouds = model.clouds?.all as NSNumber? {

            let humidityItem = WeatherDescriptionItem(title: "Облачность",
                                                      value: NumberFormatter.percentageFormatter.string(from: clouds))
            cellItems.append(humidityItem)
            cellItems.append(SpacingItem(space: 1, backgroundColor: .lightGray))
        }
        
        if let visibility = model.visibility {
            
            let visibilityValue = convertVisibility(from: visibility, with: "ru_RU")
            let visibilityItem = WeatherDescriptionItem(title: "Видимость",
                                                        value: visibilityValue)
            cellItems.append(visibilityItem)
        }
        
        items.onNext(cellItems)
    }
    
    func buildRows(cityName: String?) {

        var city: String = ""

        if let cityName = cityName {
            city = cityName
        }

        getWeather(city: city)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (weather) in
                guard let self = self else { return }
                UserDefaults.standard.set(weather.name, forKey: "city")
                self.buildRowItems(by: weather)
            })
            .disposed(by: bag)
    }
    
    func getWeather(city: String?) -> Observable<CurrentWeatherModel> {
        
        return networkService.getCurrentWeatherData(for: city)
    }
    
    private func dateFormat(by timeStamp: Double, with timezone: Int) -> String {
        
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        
        return dateFormatter.string(from: date)
        
    }
    
    private func convertPressure(from value: Double, with locale: String) -> String {
        
        let pressureFormatter = MeasurementFormatter()
        pressureFormatter.unitOptions = .providedUnit
        pressureFormatter.locale = Locale(identifier: locale)
        pressureFormatter.numberFormatter.maximumFractionDigits = 2
        pressureFormatter.numberFormatter.roundingMode = .up

        let inputValue = Measurement(value: value, unit: UnitPressure.hectopascals)
        let outputValue = inputValue.converted(to: UnitPressure.millimetersOfMercury)
        
        return pressureFormatter.string(from: outputValue)
    }
    
    private func convertVisibility(from value: Int, with locale: String) -> String {
        
        let visibilityFormatter = MeasurementFormatter()
        visibilityFormatter.unitOptions = .providedUnit
        visibilityFormatter.locale = Locale(identifier: locale)
        visibilityFormatter.numberFormatter.maximumFractionDigits = 1
        visibilityFormatter.numberFormatter.roundingMode = .up

        let inputValue = Measurement(value: Double(value), unit: UnitLength.meters)
        let outputValue = inputValue.converted(to: UnitLength.kilometers)
        
        return visibilityFormatter.string(from: outputValue)
    }
    
    private func windDirectionFromDegrees(degrees: Float) -> String {

        let directions = ["С", "ССВ", "СВ", "ВСВ", "В", "ВЮВ", "ЮВ", "ЮЮВ", "Ю", "ЮЮЗ", "ЮЗ", "ЗЮЗ", "З", "ЗСЗ", "СХ", "ССЗ"]
        let index: Int = Int((degrees + 11.25)/22.5)
        return directions[index % 16]
    }
}
