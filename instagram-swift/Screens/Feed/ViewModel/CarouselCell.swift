//
//  CarouselCell.swift
//  instagram-swift
//
//  Created by Despo on 23.11.24.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()
    
    private lazy var imageCountsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .primaryBlack
        view.layer.opacity = 0.5
        
        return view
    }()
    
    private lazy var maxCountLabel: UILabel = {
        let label = UILabel()
        label.configureCustomText(text: "", color: .white, isBold: false, size: 12)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        contentView.addSubview(image)
        contentView.addSubview(imageCountsView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            imageCountsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            imageCountsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            imageCountsView.widthAnchor.constraint(equalToConstant: 32),
            imageCountsView.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    func configure(with imageLink: String) {
        guard let url = URL(string: imageLink) else { return }
        image.imageFrom(url: url)
    }
    
}
