//
//  CollectionViewCell.swift
//  instagram-swift
//
//  Created by Giorgi Gakhokidze on 24.11.24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageConstraints()
    }
    
    private func imageConstraints() {
        contentView.addSubview(photo)
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            photo.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2),
            photo.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 2)
        ])
    }
}
