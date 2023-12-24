//
//  ViewController.swift
//  EmojiMixer
//
//  Created by admin on 28.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    //    private let emojis = [ "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]
    
    private let emojiFactory = EmojiMixFactory()
    private let emojiMixStore = EmojiMixStore()
    
    private var visibleEmoji: [EmojiMix] = []
    
    private let cellIdentifier = "cell"
    
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
    }
    
    private func setupView() {
        collectionView.register(EmpjiCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        visibleEmoji.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? EmpjiCollectionViewCell
        
        let emojiMix = visibleEmoji[indexPath.row]
        cell?.titleLable.text = emojiMix.emojies
        cell?.contentView.backgroundColor = emojiMix.backgroundColor
        guard let cell = cell else {
            print("Не получилось создать ячейку")
            return UICollectionViewCell() }
        return cell
    }
    
    @objc private func addEmoji() {
        let newMix = emojiFactory.makeNewMix()
        
        let newMixIndex = visibleEmoji.count
        visibleEmoji.append(newMix)
        
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [IndexPath(item: newMixIndex, section: 0)])
        }
    }
}

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

extension ViewController: UICollectionViewDelegateFlowLayout {
    
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

extension ViewController {
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plus))
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undo))
    }
    
    @objc func plus() {
        addEmoji()
    }
    
    //    @objc func undo() {
    //        removeEmoji()
    //    }
    
}

