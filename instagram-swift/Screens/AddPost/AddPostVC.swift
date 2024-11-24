//
//  AddPostViewController.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit
import SwiftUI

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var photoPickerHandler: PhotoPickerHandler?
    
    private lazy var photoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.configureWith(title: "x", fontSize: 20, titleColor: .white)
        button.addAction(UIAction(handler: { [weak self] action in
            self?.dismiss()
        }), for: .touchUpInside)
        return button
    
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.configureCustomText(text: "New post", color: .white, isBold: true, size: 20)
        return label
    }()
    private lazy var AddButton: UIButton = {
        let button = UIButton()
        button.configureWith(fontSize: 30, titleColor: .customBlue, image: UIImage(systemName: "plus"))
        button.addAction(UIAction(handler: { [weak self] action in
            self?.photoPickerHandler?.showPhotoPicker()
            print("add")
        }), for: .touchUpInside)
        return button
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.sizeToFit()
        imageView.image = UIImage(named: "nophoto")
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
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.itemSize = CGSize(width: 95, height: 100)
        collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionView")
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = true
        setupUI()
        photoPickerHandler = PhotoPickerHandler(presentingViewController: self)
           photoPickerHandler?.onImageSelected = { [weak self] image in
               self?.imageView.image = image
        }
    }
    
    private func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(dismissButton)
        view.addSubview(titleLabel)
        view.addSubview(AddButton)
        view.addSubview(photoView)
        photoView.addSubview(imageView)
        photoView.addSubview(recentsStackView)
        photoView.addSubview(photoButton)
        photoView.addSubview(multipleImageButton)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            photoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            photoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            photoView.heightAnchor.constraint(equalToConstant: 400),
            
            imageView.topAnchor.constraint(equalTo: photoView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: photoView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: photoView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: photoView.bottomAnchor, constant: -50),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            dismissButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            dismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            dismissButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1),
            
            AddButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            AddButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            AddButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1),

            recentsStackView.leftAnchor.constraint(equalTo: photoView.leftAnchor),
            recentsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            
            photoButton.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            photoButton.topAnchor.constraint(equalTo: recentsStackView.topAnchor),
            
            multipleImageButton.topAnchor.constraint(equalTo: recentsStackView.topAnchor),
            multipleImageButton.rightAnchor.constraint(equalTo: photoButton.leftAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: photoView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func dismiss() {
        imageView.image = UIImage(named: "nophoto")
    }
}


struct viewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AddPostVC
    

    
    
    func makeUIViewController(context: Context) -> AddPostVC{
        AddPostVC()
    }
    
    func updateUIViewController(_ uiViewController: AddPostVC, context: Context) {
        
    }
}

struct viewController_Previews: PreviewProvider {
    static var previews: some View {
        viewControllerRepresentable()
    }
}
