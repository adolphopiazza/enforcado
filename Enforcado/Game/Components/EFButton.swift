//
//  EFButton.swift
//  Enforcado
//
//  Created by Adolpho Francisco Zimmermann Piazza on 24/10/20.
//

import UIKit

class EFButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title.uppercased(), for: .normal)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EFButton {
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func disableButton() {
        backgroundColor = .systemGray
        isEnabled = false
    }
    
    func enableButton() {
        backgroundColor = .systemBlue
        isEnabled = true
    }
    
}
