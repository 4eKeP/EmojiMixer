//
//  emojiCollectionView.swift
//  EmojiMixer
//
//  Created by admin on 28.11.2023.
//

import UIKit

final class EmpjiCollectionViewCell: UICollectionViewCell {
    let titleLable = UILabel()
    
//    var viewModel: EmojiMixViewModel! {
//        didSet {
//            titleLable.text = viewModel.emojis
//            contentView.backgroundColor = viewModel.backgroundColor
//            viewModelEmpjiObserver = viewModel.observe(\.emojis, options: [.new], changeHandler: { [weak self] _, change in
//                guard let new = change.newValue else { return }
//                self?.titleLable.text = new
//            })
//            viewModelBackgroundColorObserver = viewModel.observe(\.backgroundColor, options: [.new], changeHandler: { [weak self] _, change in
//                guard let new = change.newValue else { return }
//                self?.contentView.backgroundColor = new
//            })
//        }
//    }
    
    var viewModel: EmojiMixViewModel! {
        didSet {
            titleLable.text = viewModel.emojis
            contentView.backgroundColor = viewModel.backgroundColor
        }
    }
    
    private var viewModelEmpjiObserver: NSObject?
    private var viewModelBackgroundColorObserver: NSObject?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
         viewModelEmpjiObserver = nil
        viewModelBackgroundColorObserver = nil
    }
}
