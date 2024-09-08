//
//  MainViewBuilder.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 06.09.2024.
//

import UIKit

final class MainViewBuilder {
    static func Build() -> MainViewController {
        let router = MainRouter()
        let presenter = MainPresenter(router: router)
        let vc = MainViewController(presenter: presenter)
        
        presenter.view = vc
        router.view = vc
        
        return vc
    }
}
