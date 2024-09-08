//
//  Optional+extension.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 07.09.2024.
//

import Foundation

extension Optional where Wrapped == String {
    
    var orEmpty: String {
        self ?? ""
    }
}

extension Optional where Wrapped == Double {
    func optionalRounded() -> Int {
        guard let unwrappedValue = self else {
            return 0
        }
        return Int(unwrappedValue.rounded())
    }
}

