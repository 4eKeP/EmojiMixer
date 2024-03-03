//
//  EmojiMixFactory.swift
//  EmojiMixer
//
//  Created by admin on 24.12.2023.
//

import UIKit

final class EmojiMixFactory {
    
    private let emojis = [ "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]
    
    
    func makeNewMix() -> EmojiMix {
        let emojies = make3RandomEmijes()
        
        return EmojiMix(emojies: "\(emojies.0)\(emojies.1)\(emojies.2)", backgroundColor: makeColor(emojies))
    }
    
    func makeNewFixedMix() -> EmojiMix {
        let emojies = (emojis[0], emojis[1], emojis[2])
        
        return EmojiMix(emojies: "\(emojies.0)\(emojies.1)\(emojies.2)", backgroundColor: makeColor(emojies))
    }
    
    private func make3RandomEmijes() -> (String, String, String) {
        let first = emojis.randomElement()!
        let second = emojis.randomElement()!
        let third = emojis.randomElement()!
        let returningValue = (first, second, third)
        return returningValue
        
    }
    
    private func makeColor(_ emojies: (String, String, String)) -> UIColor {
        
        func cgfload256(_ t: String) -> CGFloat {
            let value = t.unicodeScalars.reduce(Int(0)) { r, t in
                return r + Int(t.value)
            }
            return CGFloat(value % 128) / 255.0 + 0.25
        }
        return UIColor(red: cgfload256(emojies.0),
                       green: cgfload256(emojies.0),
                       blue: cgfload256(emojies.0),
                       alpha: 1)
    }
}
