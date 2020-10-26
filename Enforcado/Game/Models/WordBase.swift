//
//  WordBase.swift
//  Enforcado
//
//  Created by Adolpho Francisco Zimmermann Piazza on 25/10/20.
//

import Foundation

struct WordBase {
    
    static let words = ["Amarelo", "Amiga", "Amor", "Ave", "Aviao", "Avo", "Balao", "Bebe", "Bolo",
                        "Branco", "Cama", "Caneca", "Celular", "Clube", "Copo", "Doce", "Elefante",
                        "Escola", "Estojo", "Faca", "Foto", "Garfo", "Geleia", "Girafa", "Janela",
                        "Limonada", "Mae", "Meia", "Noite", "Oculos", "Onibus", "Ovo", "Pai", "Pao",
                        "Parque", "Passarinho", "Peixe", "Pijama", "Rato", "Umbigo"]
    
    static func getWord() -> String {
        return words.randomElement() ?? ""
    }
    
}
