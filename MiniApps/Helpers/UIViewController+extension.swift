//
//  UIViewController+extension.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 08.09.2024.
//

import UIKit

extension UIViewController {
    func errorAlert(message: String) {
        let alert = UIAlertController(title: Consts.UIConsts.errorAlertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Consts.UIConsts.alertOkButtonTitle, style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
