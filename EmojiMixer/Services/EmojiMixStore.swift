//
//  EmojiMixStore.swift
//  EmojiMixer
//
//  Created by admin on 24.12.2023.
//

import UIKit
import CoreData

final class EmojiMixStore {
    
    private let context: NSManagedObjectContext
    private let uiColorMarshalling = UIColorMarshalling()
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    convenience init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.init(context: context)
    }
    
    func addNewEmojiMix(_ emojiMix: EmojiMix) throws {
        let emojiMixCoreData = EmojisMixCoreData(context: context)
        updateExistingEmojiMix(emojiMixCoreData, with: emojiMix)
        try context.save()
    }
    
    func updateExistingEmojiMix(_ emojiMixCoreData: EmojisMixCoreData, with mix: EmojiMix) {
        emojiMixCoreData.emojies = mix.emojies
        emojiMixCoreData.colorHex = uiColorMarshalling.hexString(from: mix.backgroundColor)
    }
}
