//
//  PostCell.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

class PostCell: UICollectionViewCell {
    let customView: CustomPostView
    
    override init(frame: CGRect) {
        self.customView = CustomPostView(frame: .zero)
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
