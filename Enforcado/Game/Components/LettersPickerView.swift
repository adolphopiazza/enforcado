//
//  LettersPickerView.swift
//  Enforcado
//
//  Created by Adolpho Francisco Zimmermann Piazza on 24/10/20.
//

import UIKit

class LettersPickerView: UIPickerView {
    
    var selectedLetter: Character?
    var enableButton: Bool?
    var button: EFButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPickerView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Layouts
extension LettersPickerView {
    
    private func setupPickerView() {
        translatesAutoresizingMaskIntoConstraints = false
    
        dataSource = self
        delegate = self
        
        transform = CGAffineTransform(rotationAngle: -90  * (.pi/180))
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
}

//MARK: - Delegates
extension LettersPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GameLogic.shared.alphabet.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let letter: UILabel = UILabel()
        
        letter.textColor = .label
        letter.textAlignment = .center
        letter.font = UIFont.systemFont(ofSize: 50)
        letter.text = String(GameLogic.shared.alphabet[row])
        
        letter.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
        return letter
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        enableButton = true
        button?.enableButton()
        
        if GameLogic.shared.alphabet[row] == " " {
            button?.disableButton()
        } else {
            selectedLetter = GameLogic.shared.alphabet[row]
        }
        
    }
    
}
