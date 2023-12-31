//
//  EmojiMixesViewModel.swift
//  EmojiMixer
//
//  Created by admin on 07.01.2024.
//

import UIKit

//@objcMembers
final class EmojiMixesViewModel {
    
   // var onChange: (() -> Void)?
    
    @Observable
    private(set) var emojiMixes: [EmojiMixViewModel] = []
//    {
//        didSet {
//            onChange?()
//        }
//    }
    
    private let emojiMixStore: EmojiMixStore
    private let emojiMixFactory: EmojiMixFactory
    private let uiColorMarshalling = UIColorMarshalling()
    
    convenience init() {
        let emojiMixStore = try! EmojiMixStore(
            context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        )
        self.init(emojiMixFactory: EmojiMixFactory(), emojiMixStore: emojiMixStore)
    }
   
    
    init(emojiMixFactory: EmojiMixFactory, emojiMixStore: EmojiMixStore) {
        self.emojiMixFactory = emojiMixFactory
        self.emojiMixStore = emojiMixStore
      //  super.init()
        emojiMixStore.delegate = self
        emojiMixes = getEmojiMixesFromeStore()
    }
    
    func addEmojiMixTapped() {
        let newMix = emojiMixFactory.makeNewMix()
        try! emojiMixStore.addNewEmojiMix(newMix)
    }
    
    func deleteAll() {
        try! emojiMixStore.deleteAll()
    }
    
    func getEmojiMixesFromeStore() -> [EmojiMixViewModel] {
        return emojiMixStore.emojiMixes.map {
            EmojiMixViewModel(id: $0.objectID.uriRepresentation().absoluteString,
                              emojis: $0.emojies ?? "",
                              backgroundColor: uiColorMarshalling.color(from: $0.colorHex ?? ""))
        }
    }
}

extension EmojiMixesViewModel: EmojiMixStoreDelegate {
    func storeDidUpdate(_ store: EmojiMixStore) {
        emojiMixes = getEmojiMixesFromeStore()
    }
}
