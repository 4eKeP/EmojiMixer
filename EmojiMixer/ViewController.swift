//
//  ViewController.swift
//  EmojiMixer
//
//  Created by admin on 28.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private let emojis = [ "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]
    
    private var visibleEmoji: [String] = []

    private let cellIdentifier = "cell"
    
    var collectionView: UICollectionView = {
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
        
        cell?.titleLable.text = visibleEmoji[indexPath.row]
        guard let cell = cell else {
            print("Не получилось создать ячейку")
            return UICollectionViewCell() }
        return cell
    }
    
    @objc private func addEmoji() {
        guard visibleEmoji.count < emojis.count else { return }
        
        let nextEmojiIndex = visibleEmoji.count
        visibleEmoji.append(emojis[nextEmojiIndex])
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [IndexPath(item: nextEmojiIndex, section: 0)])
        }
    }
    
    @objc private func removeEmoji() {
        guard visibleEmoji.count > 0 else { return }
        
        let lastEmojiIndex = visibleEmoji.count - 1
        visibleEmoji.removeLast()
        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: [IndexPath(item: lastEmojiIndex, section: 0)])
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    // задается рамер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: 50)
    }
    
    //задаеться растояние между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: NavigationBar

extension ViewController {
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plus))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undo))
    }
    
    @objc func plus() {
        addEmoji()
    }
    
    @objc func undo() {
        removeEmoji()
    }
    
}

