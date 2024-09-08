//
//  CrosswordViewController.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 07.09.2024.
//

import UIKit
import SnapKit

final class CrosswordViewController: UIViewController {
    
    let words = ["CAT", "DOG", "BIRD"]
    var textFields: [[UITextField]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCrossword()
        setupCheckButton()
    }
    
    func setupCrossword() {
        let fieldSize: CGFloat = 50
        let padding: CGFloat = 10
        
        for (rowIndex, word) in words.enumerated() {
            var textFieldRow: [UITextField] = []
            
            for (columnIndex, _) in word.enumerated() {
                let textField = UITextField()
                textField.borderStyle = .roundedRect
                textField.textAlignment = .center
                textField.font = UIFont.systemFont(ofSize: 24)
                textField.keyboardType = .default
                textField.placeholder = " "
                textField.delegate = self
                textField.tag = rowIndex * 10 + columnIndex
                textField.textContentType = .oneTimeCode 
                view.addSubview(textField)
                textFieldRow.append(textField)
                
                textField.snp.makeConstraints { make in
                    make.width.height.equalTo(fieldSize)
                    make.left.equalToSuperview().offset(CGFloat(columnIndex) * (fieldSize + padding))
                    make.top.equalToSuperview().offset(CGFloat(rowIndex) * (fieldSize + padding) + 100)
                }
            }
            textFields.append(textFieldRow)
        }
    }
    
    func setupCheckButton() {
        let checkButton = UIButton(type: .system)
        checkButton.setTitle("Проверить", for: .normal)
        checkButton.addTarget(self, action: #selector(checkAnswers), for: .touchUpInside)
        
        view.addSubview(checkButton)
        
        checkButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(300)
        }
    }
    
    @objc func checkAnswers() {
        var userAnswers = [String]()
        
        for row in textFields {
            let word = row.compactMap { $0.text?.uppercased() }.joined()
            userAnswers.append(word)
        }
        
        for (index, word) in userAnswers.enumerated() {
            for (columnIndex, textField) in textFields[index].enumerated() {
                if columnIndex < word.count {
                    let char = word[word.index(word.startIndex, offsetBy: columnIndex)]
                    if let correctChar = words[index].getCharacter(at: columnIndex) {
                        if char == correctChar {
                            textField.backgroundColor = .green
                        } else {
                            textField.backgroundColor = .red
                        }
                    }
                } else {
                    textField.backgroundColor = .clear
                }
            }
        }
    }
}

extension CrosswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count > 1 { return false }
        if string.isEmpty { return true }
        
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
