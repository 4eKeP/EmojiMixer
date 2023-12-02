//
//  emojiCollectionView.swift
//  EmojiMixer
//
//  Created by admin on 28.11.2023.
//

import UIKit

final class EmpjiCollectionViewCell: UICollectionViewCell {
    let titleLable = UILabel()
    
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
    }
}
