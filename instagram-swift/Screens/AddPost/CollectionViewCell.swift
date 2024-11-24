//
//  CollectionViewCell.swift
//  instagram-swift
//
//  Created by Giorgi Gakhokidze on 24.11.24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private lazy var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Rectangle")
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
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photo.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
