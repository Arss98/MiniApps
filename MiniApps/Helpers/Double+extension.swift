//
//  Double+extension.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 08.09.2024.
//

import Foundation

extension Double {
    func customRounded() -> Int {
        return Int(self.rounded())
    }
}
