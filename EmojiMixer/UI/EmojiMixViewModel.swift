//
//  EmojiMixViewModel.swift
//  EmojiMixer
//
//  Created by admin on 07.01.2024.
//

import UIKit

@objcMembers
final class EmojiMixViewModel: NSObject, Identifiable {
    
    let id: String
    private(set) dynamic var emojis: String
    private(set) dynamic var backgroundColor: UIColor
    
    init(id: String, emojis: String, backgroundColor: UIColor) {
        self.id = id
        self.emojis = emojis
        self.backgroundColor = backgroundColor
        super.init()
    }
    
}
