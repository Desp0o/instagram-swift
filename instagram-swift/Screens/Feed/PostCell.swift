//
//  PostCell.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

class PostCell: UICollectionViewCell {
    let customView: CustomPostView
    
    // Proper initialization with `frame` and default value for `customView`
    override init(frame: CGRect) {
        self.customView = CustomPostView()  // Initialize customView here
        super.init(frame: frame)  // Call the designated initializer of UICollectionViewCell
        setupUI()
    }
    
    
    
    // Required initializer for decoding (if you ever use storyboard or nib)
    required init?(coder: NSCoder) {
        self.customView = CustomPostView()  // Initialize customView here as well
        super.init(coder: coder)
        setupUI()
    }
    
    // Configure cell with PostModel
    func configureCell(with post: PostModel) {
        customView.setupView(with: post)
    }
    
    private func setupUI() {
        contentView.backgroundColor = .red
        contentView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
