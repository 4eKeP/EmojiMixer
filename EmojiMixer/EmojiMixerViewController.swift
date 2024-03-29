//
//  EmojiMixerViewController.swift
//  EmojiMixer
//
//  Created by admin on 28.11.2023.
//

import UIKit

final class EmojiMixerViewController: UIViewController {
    
    //    private let emojis = [ "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]
    
    //  private let emojiFactory = EmojiMixFactory()
    //   private let emojiMixStore = EmojiMixStore()
    
    private var viewModel: EmojiMixesViewModel!
  //  private var viewModelObserver: NSObject?
    
   // private var visibleEmoji: [EmojiMix] = []
    
    private let cellIdentifier = "cell"
    
    private let colors = Colors()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        collectionView.allowsMultipleSelection = false
        setNavigationBar()
        viewModel = EmojiMixesViewModel()
//        viewModelObserver = viewModel.observe(\.emojiMixes,
//                                               options: []) { [weak self] _, change in
//            guard let self = self else { return }
//            self.collectionView.reloadData()
//        }
        viewModel.$emojiMixes.bind { [weak self] _ in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
    private func setupView() {
        collectionView.register(EmpjiCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.backgroundColor = colors.collectionViewBackgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension EmojiMixerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.emojiMixes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? EmpjiCollectionViewCell
        cell?.viewModel = viewModel.emojiMixes[indexPath.item]
//        let emojiMix = visibleEmoji[indexPath.row]
//        cell?.titleLable.text = emojiMix.emojies
//        cell?.contentView.backgroundColor = emojiMix.backgroundColor
        guard let cell = cell else {
            print("Не получилось создать ячейку")
            return UICollectionViewCell() }
        return cell
    }
    
//    @objc private func addEmoji() {
//        let newMix = emojiFactory.makeNewMix()
//        try! emojiMixStore.addNewEmojiMix(newMix)
        //        let newMixIndex = visibleEmoji.count
        //        try! emojiMixStore.addNewEmojiMix(newMix)
        //        visibleEmoji = try! emojiMixStore.fetchEmojiMixes()
        //
        //        collectionView.performBatchUpdates {
        //            collectionView.insertItems(at: [IndexPath(item: newMixIndex, section: 0)])
        //        }
 //   }
}

extension EmojiMixerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

//extension ViewController: EmojiMixStoreDelegate {

//    func store(_ store: EmojiMixStore, didUpdate update: EmojiMixStoreUpdate) {
//        visibleEmoji = emojiMixStore.emojiMixes
//        collectionView.performBatchUpdates {
//            let insertedIndexes = update.insertedIndexes.map { IndexPath(item: $0, section: 0) }
//            let deletedIndexes = update.deletedIndexes.map { IndexPath(item: $0, section: 0) }
//            let updatedIndexes = update.updatedIndexes.map { IndexPath(item: $0, section: 0) }
//            collectionView.insertItems(at: insertedIndexes)
//            collectionView.insertItems(at: deletedIndexes)
//            collectionView.insertItems(at: updatedIndexes)
//            for move in update.movedIndexes {
//                collectionView.moveItem(at: IndexPath(item: move.oldIndex, section: 0),
//                                        to: IndexPath(item: move.newIndex, section: 0))
//            }
//        }
//    }

//}

//    @objc private func removeEmoji() {
//        guard visibleEmoji.count > 0 else { return }
//
//        let lastEmojiIndex = visibleEmoji.count - 1
//        visibleEmoji.removeLast()
//        collectionView.performBatchUpdates {
//            collectionView.deleteItems(at: [IndexPath(item: lastEmojiIndex, section: 0)])
//        }
//    }
//}

extension EmojiMixerViewController: UICollectionViewDelegateFlowLayout {
    
    // задается рамер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = collectionView.contentInset
        let availableWidth = collectionView.bounds.width - insets.left - insets.right
        let minSpacing = 10.0
        let itemsPerRow = 2.0
        let itemWidth = (availableWidth - (itemsPerRow - 1) * minSpacing)  / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    //задаеться растояние между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//MARK: NavigationBar

extension EmojiMixerViewController {
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plus))
        
        let leftButton = UIBarButtonItem(
            title: NSLocalizedString("deleteAll", comment: "Text on delete button"),
            style: .plain,
            target: self,
            action: #selector(undo)
        )
        self.navigationItem.leftBarButtonItem = leftButton
       // self.navigationItem.title = NSLocalizedString("emptyState.title", comment: "Text displayed on empty state")
    }
    
    @objc func plus() {
        viewModel.addEmojiMixTapped()
    }
    
    @objc func undo() {
        viewModel.deleteAll()
    }
    
}

