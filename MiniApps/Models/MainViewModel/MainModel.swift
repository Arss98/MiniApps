//
//  Model.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 06.09.2024.
//

import Foundation

struct MiniAppModel {
    let title: String
    let type: MiniAppType
}

enum MiniAppType {
    case weather
    case crossword
}
