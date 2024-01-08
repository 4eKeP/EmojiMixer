//
//  EmojiMixStore.swift
//  EmojiMixer
//
//  Created by admin on 24.12.2023.
//

import UIKit
import CoreData

enum EmojiMixStoreError: Error {
    case decodingErrorInvalidEmojies
    case decodingErrorInvalidColorHex
}

//struct EmojiMixStoreUpdate{
//    struct Move: Hashable {
//        let oldIndex: Int
//        let newIndex: Int
//    }
//    
//    let insertedIndexes: IndexSet
//    let deletedIndexes: IndexSet
//    let updatedIndexes: IndexSet
//    let movedIndexes: Set<Move>
//}

protocol EmojiMixStoreDelegate: AnyObject {
    func storeDidUpdate(_ store: EmojiMixStore)
}

final class EmojiMixStore: NSObject {
    
    private let context: NSManagedObjectContext
    private let uiColorMarshalling = UIColorMarshalling()
    private var fetchResultsController: NSFetchedResultsController<EmojisMixCoreData>!
    
    weak var delegate: EmojiMixStoreDelegate?
//    private var insertedIndexes: IndexSet?
//    private var deletedIndexes: IndexSet?
//    private var updatedIndexes: IndexSet?
//    private var movedIndexes: Set<EmojiMixStoreUpdate.Move>?
    
    var emojiMixes: [EmojisMixCoreData] {
//        guard
//            let object = self.fetchResultsController.fetchedObjects,
//            let emojiMixes = try? object.map({ try self.emojiMix(from: $0) })
//        else {return []}
//        return emojiMixes
        return self.fetchResultsController.fetchedObjects ?? []
    }
    
//    convenience override init() {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        try! self.init(context: context)
//    }
    
    init(context: NSManagedObjectContext) throws {
        self.context = context
        super.init()
        
        let fetchRequest = EmojisMixCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(
            keyPath: \EmojisMixCoreData.emojies,
            ascending: true)]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        controller.delegate = self
        self.fetchResultsController = controller
        try controller.performFetch()
    }
    
    func addNewEmojiMix(_ emojiMix: EmojiMix) throws {
        let emojiMixCoreData = EmojisMixCoreData(context: context)
//        emojiMixCoreData.emojies = emojiMix.emojies
//        emojiMixCoreData.colorHex = uiColorMarshalling.hexString(from: emojiMix.backgroundColor)
        updateExistingEmojiMix(emojiMixCoreData, with: emojiMix)
        try context.save()
    }
    
    func updateExistingEmojiMix(_ emojiMixCoreData: EmojisMixCoreData, with mix: EmojiMix) {
        emojiMixCoreData.emojies = mix.emojies
        emojiMixCoreData.colorHex = uiColorMarshalling.hexString(from: mix.backgroundColor)
    }
    
    func deleteAll() throws {
        let objects = fetchResultsController.fetchedObjects ?? []
        for object in objects {
            context.delete(object)
        }
        try context.save()
    }
    
//    func fetchEmojiMixes() throws -> [EmojiMix] {
//        let fetchRequest = EmojisMixCoreData.fetchRequest()
//        
//        let emojiMixesFromCoreData = try context.fetch(fetchRequest)
//        
//        return try emojiMixesFromCoreData.map { try self.emojiMix(from: $0)
//        }
//    }
    
    func emojiMix(from emojiMixCoreData: EmojisMixCoreData) throws -> EmojiMix {
        guard let emojies = emojiMixCoreData.emojies else {
            throw EmojiMixStoreError.decodingErrorInvalidEmojies
        }
        guard let colorHex = emojiMixCoreData.colorHex else { throw EmojiMixStoreError.decodingErrorInvalidColorHex
        }
        return EmojiMix(emojies: emojies, 
                        backgroundColor: uiColorMarshalling.color(from: colorHex))
    }
}

extension EmojiMixStore: NSFetchedResultsControllerDelegate {
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        insertedIndexes = IndexSet()
//        deletedIndexes = IndexSet()
//        updatedIndexes = IndexSet()
//        movedIndexes = Set<EmojiMixStoreUpdate.Move>()
//    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        delegate?.store(self, didUpdate: EmojiMixStoreUpdate(
//            insertedIndexes: insertedIndexes!,
//            deletedIndexes: deletedIndexes!,
//            updatedIndexes: updatedIndexes!,
//            movedIndexes: movedIndexes!))
//        
//        insertedIndexes = nil
//        deletedIndexes = nil
//        updatedIndexes = nil
//        movedIndexes = nil
        delegate?.storeDidUpdate(self)
    }
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            guard let indexPath = newIndexPath else { fatalError() }
//            insertedIndexes?.insert(indexPath.item)
//        case .delete:
//            guard let indexPath = indexPath else { fatalError() }
//            deletedIndexes?.insert(indexPath.item)
//        case .update:
//            guard let indexPath = indexPath else { fatalError() }
//            updatedIndexes?.insert(indexPath.item)
//        case .move:
//            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else { fatalError() }
//            movedIndexes?.insert(.init(oldIndex: oldIndexPath.item, newIndex: newIndexPath.item))
//        @unknown default:
//            fatalError()
//        }
//    }
}
