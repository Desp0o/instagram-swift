//
//  PostCollectionViewCell.swift
//  instagram-swift
//
//  Created by nino on 11/23/24.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(postImage)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            postImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            postImage.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}
   
