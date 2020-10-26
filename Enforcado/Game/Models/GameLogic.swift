//
//  Alphabet.swift
//  Enforcado
//
//  Created by Adolpho Francisco Zimmermann Piazza on 24/10/20.
//

import Foundation

class GameLogic {
    
    static let shared = GameLogic()
    
    var yourLife: Int = 6
    var wordToGuess: [Character] = []
    var word: [Character] = []
    var alphabet: [Character] = [" ", "A", "B", "C", "D",
                                 "E", "F", "G", "H", "I",
                                 "J", "K", "L", "M", "N",
                                 "O", "P", "Q", "R", "S",
                                 "T", "U", "V", "X", "Z"]
    var delegate: GameDelegate?
    
    private init() {}
    
    func startGame() {
        wordToGuess = Array(WordBase.getWord().uppercased())
        print(wordToGuess)
        
        for _ in wordToGuess {
            word.append("_")
        }
    }
    
    func selectLetter(_ letter: Character) {
        alphabet = alphabet.filter({$0 != letter})
        
        if !isMatch(with: letter) {
            yourLife -= 1
            delegate?.refreshLife()
        } else if checkIfWon() {
            delegate?.wonGame()
        }
    }
    
    func isMatch(with letter: Character) -> Bool {
        var isHit: Bool = false
        
        for (i, char) in wordToGuess.enumerated() {
            if char == letter {
                isHit = true
                word[i] = letter
            }
        }
        
        delegate?.refreshPicker()
        delegate?.refreshLabel()
        
        return isHit
    }
    
    func checkIfWon() -> Bool {
        return !word.contains("_")
    }
    
    func resetGame() {
        yourLife = 6
        word.removeAll()
        alphabet = [" ", "A", "B", "C", "D",
                    "E", "F", "G", "H", "I",
                    "J", "K", "L", "M", "N",
                    "O", "P", "Q", "R", "S",
                    "T", "U", "V", "X", "Z"]
        
        startGame()
        delegate?.refreshPicker()
        delegate?.refreshLabel()
        delegate?.refreshLife()
    }
    
}
