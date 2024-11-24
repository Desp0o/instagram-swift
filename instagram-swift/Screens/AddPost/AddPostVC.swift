//
//  AddPostViewController.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit
import SwiftUI

class AddPostVC: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private lazy var photoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.configureWith(title: "X", fontSize: 28, titleColor: .white)
        return button
    
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.configureCustomText(text: "New post", color: .white, isBold: true, size: 20)
        return label
    }()
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.configureWith(title: "Next", fontSize: 20, titleColor: .customBlue)
        return button
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        return imageView
    }()
    private lazy var recentsStackView: UIStackView = {
        let label = UILabel()
        label.configureCustomText(text: "Recent", color: .white, isBold: true, size: 16)
    
        let chevronImageView = UIImageView()
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = .white
        chevronImageView.contentMode = .scaleAspectFit

        let stackView = UIStackView(arrangedSubviews: [label, chevronImageView])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    private lazy var photoButton: UIButton = {
        let button = UIButton()
        button.configureWith(image: UIImage(systemName: "camera.circle"))
        return button
    }()
    private lazy var multipleImageButton: UIButton = {
        let button = UIButton()
        button.configureWith(image: UIImage(systemName: "square.on.square"))
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection: UICollectionView
        let collectionLayout = UICollectionViewFlowLayout()
    
        collectionLayout.itemSize = CGSize(width: view.frame.width, height: 50)
        collectionLayout.minimumLineSpacing = 0
        collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionView")
        return collection
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.titleView = titleLabel
    
        setupUI()
    }
    
    private func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(dismissButton)
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        view.addSubview(photoView)
        photoView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        photoView.addSubview(recentsStackView)
        photoView.addSubview(photoButton)
        photoView.addSubview(multipleImageButton)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        
        imageView.image = UIImage(named: "Rectangle")
        NSLayoutConstraint.activate([
            
            photoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            photoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            photoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            photoView.heightAnchor.constraint(equalToConstant: 400),
            
            scrollView.topAnchor.constraint(equalTo: photoView.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: photoView.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: photoView.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: photoView.bottomAnchor, constant: -50),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            dismissButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            dismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            dismissButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1),
            
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            nextButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            nextButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            
            recentsStackView.leftAnchor.constraint(equalTo: photoView.leftAnchor),
            recentsStackView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 15),
            
            photoButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            photoButton.topAnchor.constraint(equalTo: recentsStackView.topAnchor),
            
            multipleImageButton.topAnchor.constraint(equalTo: recentsStackView.topAnchor),
            multipleImageButton.rightAnchor.constraint(equalTo: photoButton.leftAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: photoView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

//
//struct viewControllerRepresentable: UIViewControllerRepresentable {
//    typealias UIViewControllerType = AddPostVC
//    
//
//    
//    
//    func makeUIViewController(context: Context) -> AddPostVC{
//        AddPostVC()
//    }
//    
//    func updateUIViewController(_ uiViewController: AddPostVC, context: Context) {
//        
//    }
//}
//
//struct viewController_Previews: PreviewProvider {
//    static var previews: some View {
//        viewControllerRepresentable()
//    }
//}
