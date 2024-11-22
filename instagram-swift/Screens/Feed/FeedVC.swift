//
//  ViewController.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit
import Foundation

class FeedVC: UIViewController, FeedViewModelDelegate {
    
    
    let feedViewModel: FeedViewModel
    private let topBar = UIView()
    private let logo = UIImageView()
    
    
    
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
    
    init(feedViewModel: FeedViewModel = FeedViewModel()) {
        self.feedViewModel = feedViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedViewModel.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(collection)
        
        setupTopBar()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 0),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
            
        ])
    }
    
    private func setupTopBar() {
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        
        topBar.backgroundColor = .tabBarCol
        
        NSLayoutConstraint.activate([
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topBar.heightAnchor.constraint(equalToConstant: 112)
        ])
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.secondaryGray
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        topBar.addSubview(bottomLine)
        
        NSLayoutConstraint.activate([
            bottomLine.leadingAnchor.constraint(equalTo: topBar.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: topBar.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: topBar.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        setupBarLogo()
    }
    
    private func setupBarLogo() {
        topBar.addSubview(logo)
        
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
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
        feedViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as? PostCell
        
        if let currentPost = feedViewModel.singlePost(with: indexPath.row) {
            cell?.configureCell(with: currentPost)
        } else {
            print("Post is nil")
        }
        
        return cell ?? PostCell()
    }
    
    
}
