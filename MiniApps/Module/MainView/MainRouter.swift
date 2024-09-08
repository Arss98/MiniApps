//
//  MainRouter.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 06.09.2024.
//
import UIKit

class MainRouter {
    weak var view: MainViewController?
    
    func routeToMiniApp(miniApp: MiniAppModel) {
        var destination: UIViewController?
        
        switch miniApp.type {
        case .weather:
            destination = WeatherBuilder.Build()
        case .crossword:
            destination = CrosswordViewController()
        }
        
        if let destinationVC = destination {
            view?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
