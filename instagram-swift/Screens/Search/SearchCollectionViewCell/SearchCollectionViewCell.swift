//
//  SearchCollectionViewCell.swift
//  instagram-swift
//
//  Created by MacBook on 24.11.24.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {
    
    private lazy var multiImagesView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "multiImages")
        return imageView
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCellUI()
    }
    
    static let identifier = "SearchCollectionViewCell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCellUI() {
        backgroundColor = .clear
        
        contentView.addSubview(photoImageView)
        
        setUpCellConstraints()
        setupMultiImageView()
    }
    
    private func setUpCellConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupMultiImageView() {
        
    }
    
    public func configureSearchCollectionViewCell(with image: String) {
        
    }
}
