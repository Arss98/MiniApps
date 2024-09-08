//
//  String+extension.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 08.09.2024.
//

import UIKit

extension String {
    func timeFromDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func getCharacter(at index: Int) -> Character? {
        guard index >= 0 && index < self.count else { return nil }
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
