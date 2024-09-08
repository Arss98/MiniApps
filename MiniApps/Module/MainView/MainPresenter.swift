//
//  MainPresenter.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 06.09.2024.
//

import Foundation

protocol MainView: AnyObject {
    func displayMiniApps(_ miniApps: [MiniAppModel])
}

class MainPresenter {
    weak var view: MainView?
    private var miniApps: [MiniAppModel] = []
    private var router: MainRouter

    init(router: MainRouter) {
        self.router = router
        self.setupMiniApps()
    }

    private func setupMiniApps() {
        miniApps = [
            MiniAppModel(title: Consts.UIConsts.weatherTitle, type: .weather),
            MiniAppModel(title: Consts.UIConsts.crossword, type: .crossword),
            MiniAppModel(title: Consts.UIConsts.weatherTitle, type: .weather),
            MiniAppModel(title: Consts.UIConsts.crossword, type: .crossword),
            MiniAppModel(title: Consts.UIConsts.weatherTitle, type: .weather),
            MiniAppModel(title: Consts.UIConsts.crossword, type: .crossword),
            MiniAppModel(title: Consts.UIConsts.weatherTitle, type: .weather),
            MiniAppModel(title: Consts.UIConsts.crossword, type: .crossword),
            MiniAppModel(title: Consts.UIConsts.weatherTitle, type: .weather),
            MiniAppModel(title: Consts.UIConsts.crossword, type: .crossword),
            MiniAppModel(title: Consts.UIConsts.weatherTitle, type: .weather),
            MiniAppModel(title: Consts.UIConsts.crossword, type: .crossword),
        ]
        view?.displayMiniApps(miniApps)
    }
    
    func miniAppSelected(at index: Int) -> MiniAppModel {
        return miniApps[index]
    }
    
    func miniAppCount() -> Int {
        return miniApps.count
    }
    
    func didSelectMiniApp(at index: Int) {
        let miniApp = miniAppSelected(at: index)
        router.routeToMiniApp(miniApp: miniApp)
    }
}
