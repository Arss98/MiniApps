//
//  WeatherPresenter.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 07.09.2024.
//

import Foundation
import Alamofire
import CoreLocation

protocol WeatherViewProtocol: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func updateWeather(_ weatherModel: WeatherModel)
    func showError(_ message: String)
    
}

final class WeatherPresenter {
    weak var view: WeatherViewProtocol?
    private var apiService: ApiService
    
    var weatherModel: WeatherModel?
    var hourlyData: [Current]?
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
}

extension WeatherPresenter {
    func fetchWeather(for city: String) {
        view?.showLoadingIndicator()
        
        apiService.fetchWeather(city: city) { [weak self] result in
            switch result {
            case .success(let weatherModel):
                self?.hourlyData = weatherModel.forecast?.forecastday.first?.hour
                self?.view?.updateWeather(weatherModel)
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
            self?.view?.hideLoadingIndicator()
        }
    }
    
    func getCityName(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                self.view?.showError(error.localizedDescription)
                return
            }
            guard let placemark = placemarks?.first,
                  let city = placemark.locality else {
                self.view?.showError(Consts.UIConsts.cityNotFoundMessage)
                return
            }
            
            self.fetchWeather(for: city)
        }
    }
}
