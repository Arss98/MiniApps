//
//  WeatherBuilder.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 07.09.2024.
//

import UIKit

final class WeatherBuilder {
    static func Build() -> WeatherViewController {
        let apiService = ApiService()
        let presenter = WeatherPresenter(apiService: apiService)
        let vc = WeatherViewController(presenter: presenter)
        
        presenter.view = vc
        
        return vc
    }
}
