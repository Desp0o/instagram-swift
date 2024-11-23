//
//  ViewController.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit
import Foundation

class FeedVC: UIViewController, FeedViewModelDelegate {
    
    let postViewModel: PostViewModel
    
    private lazy var topBar: UIView = {
        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = .tabBarCol
        
        return bar
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondaryGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        return logo
    }()
    
    private lazy var collection: UICollectionView = {
        let collection: UICollectionView
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        
        collectionLayout.itemSize = CGSize(width: view.frame.width, height: 625)
        collectionLayout.minimumLineSpacing = 0
        collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        collection.backgroundColor = .secondarySystemBackground
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        
        return collection
    }()
    
    init(postViewModel: PostViewModel = PostViewModel()) {
        self.postViewModel = postViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postViewModel.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(collection)
        view.addSubview(topBar)
        topBar.addSubview(bottomLine)
        topBar.addSubview(logo)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topBar.heightAnchor.constraint(equalToConstant: 112),
            
            collection.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 0),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
            
            bottomLine.leadingAnchor.constraint(equalTo: topBar.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: topBar.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: topBar.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            
            logo.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            logo.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -6)
        ])
    }
    
    func didFinishFetchingData() {
        collection.reloadData()
    }
}

extension FeedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        postViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as? PostCell
        
        if let currentPost = postViewModel.singlePost(with: indexPath.row) {
            cell?.configureCell(with: currentPost)
        } else {
            print("Post is nil")
        }
        
        return cell ?? PostCell()
    }
}
