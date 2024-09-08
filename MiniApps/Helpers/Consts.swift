//
//  Consts.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 07.09.2024.
//

import Foundation

struct Consts {
    struct UIConsts {
        static let mainListTitle = "MiniApps"
        static let weatherTitle = "Прогноз погоды"
        static let crossword = "Кроссворд"
        static let maxTemp = "Max: "
        static let minTemp = "Min: "
        static let degreeSymbol = "\u{00B0}"
        static let errorAlertTitle = "Error"
        static let alertOkButtonTitle = "Ок"
        static let cityNotFoundMessage = "City not found"
        static let switchButton = "Switch"
    }
    
    struct requestConsts {
        static let baseUrl = "https://api.weatherapi.com/v1/forecast.json"
        static let apiKey = "e1b705fd7e3744fbbd292755231708"
        static let domain = "WeatherService"
    }
}
