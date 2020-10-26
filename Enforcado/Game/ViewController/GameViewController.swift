//
//  GameViewController.swift
//  Enforcado
//
//  Created by Adolpho Francisco Zimmermann Piazza on 24/10/20.
//

import UIKit

protocol GameDelegate {
    func refreshPicker()
    func refreshLabel()
    func refreshLife()
    func wonGame()
}

class GameViewController: UIViewController {
    
    private let yourLifeLabel: UILabel = UILabel()
    private let wordToGuessLabel: UILabel = UILabel()
    private let alphabetPicker: LettersPickerView = LettersPickerView()
    private let selectLetter: EFButton = EFButton(title: "Selecionar Letra")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupYourLife()
        setupWordToGuessLabel()
        setupAlphabetPicker()
        setupSelectLetterButton()
    }

}

//MARK: - Actions
extension GameViewController {
    
    @objc private func selectLetterAction() {
        guard let selectedLetter = alphabetPicker.selectedLetter else { return }
        
        GameLogic.shared.selectLetter(selectedLetter)
    }
    
}

//MARK: - Delegates
extension GameViewController: GameDelegate {
    
    func refreshPicker() {
        alphabetPicker.reloadAllComponents()
        alphabetPicker.selectRow(0, inComponent: 0, animated: true)
        alphabetPicker.enableButton = false
        selectLetter.disableButton()
    }
    
    func refreshLabel() {
        wordToGuessLabel.text = String(GameLogic.shared.word)
    }
    
    func refreshLife() {
        let life = GameLogic.shared.yourLife
        
        if life == 0 {
            let alert = UIAlertController(title: "Perdeu!", message: "A palavra era: \(String(GameLogic.shared.wordToGuess))\nVamos recomeçar o jogo...", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                GameLogic.shared.resetGame()
            }))
            
            yourLifeLabel.text = "Zero pontos"
            self.present(alert, animated: true)
        } else {
            yourLifeLabel.text = "Sua vida: \(GameLogic.shared.yourLife)"
        }
    }
    
    func wonGame() {
        let alert = UIAlertController(title: "Ganhou!", message: "Parabéns, você ganhou o game", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Recomeçar", style: .default, handler: { (alert) in
            GameLogic.shared.resetGame()
        }))
        
        self.present(alert, animated: true)
    }
    
}

//MARK: - Layouts
extension GameViewController {
    
    private func setupView() {
        GameLogic.shared.delegate = self
        GameLogic.shared.startGame()
        alphabetPicker.button = selectLetter
        view.backgroundColor = .systemBackground
    }
    
    private func setupWordToGuessLabel() {
        wordToGuessLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wordToGuessLabel)
        
        let attributedString = NSMutableAttributedString(string: String(GameLogic.shared.word))
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 8, range: NSRange(location: 0, length: attributedString.length))
        
        wordToGuessLabel.attributedText = attributedString
        wordToGuessLabel.textColor = .label
        wordToGuessLabel.font = UIFont.systemFont(ofSize: 40)
        
        NSLayoutConstraint.activate([
            wordToGuessLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -65),
            wordToGuessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupYourLife() {
        yourLifeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yourLifeLabel)
        
        yourLifeLabel.text = "Sua vida: \(GameLogic.shared.yourLife)"
        yourLifeLabel.textColor = .label
        yourLifeLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        NSLayoutConstraint.activate([
            yourLifeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
            yourLifeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupAlphabetPicker() {
        view.addSubview(alphabetPicker)
        
        NSLayoutConstraint.activate([
            alphabetPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            alphabetPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupSelectLetterButton() {
        view.addSubview(selectLetter)
        
        selectLetter.disableButton()
        selectLetter.addTarget(self, action: #selector(selectLetterAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            selectLetter.bottomAnchor.constraint(equalTo: alphabetPicker.topAnchor),
            selectLetter.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectLetter.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}
