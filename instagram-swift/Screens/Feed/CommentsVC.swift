//
//  CommentsVCViewController.swift
//  instagram-swift
//
//  Created by Despo on 25.11.24.
//

import UIKit

class CommentsVC: UIViewController {
    private var commentsArray: [Comment]

    private lazy var pageTitle: UILabel = {
        let label = UILabel()
        label.configureCustomText(text: "Comments", color: .primaryBlack, isBold: true, size: 20)
        return label
    }()
    
    private lazy var collection: UICollectionView = {
        let collection: UICollectionView
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.itemSize = CGSize(width: view.frame.width, height: 50)
        collectionLayout.minimumLineSpacing = 10
        collectionLayout.collectionView?.bounces = false
        collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.bounces = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CommentCell.self, forCellWithReuseIdentifier: "CommentCell")
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false

        return collection
    }()
    
    init(commentsArray: [Comment]) {
        self.commentsArray = commentsArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(pageTitle)
        view.addSubview(collection)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collection.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 30),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ])
    }

}


extension CommentsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        commentsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as? CommentCell
        let currentComment = commentsArray[indexPath.row]
        cell?.configureCell(with: currentComment)
        return cell ?? CommentCell()
    }
}
