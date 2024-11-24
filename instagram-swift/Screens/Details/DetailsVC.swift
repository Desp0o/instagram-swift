//
//  ViewController.swift
//  instagram-swift
//
//  Created by Despo on 23.11.24.
//

import UIKit

class DetailsVC: UIViewController {
    var customView: CustomPostView
    var model: PostModel
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private lazy var postView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var topBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tabBarCol
        
        return view
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondaryGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var barTitle: UILabel = {
        let label = UILabel()
        label.configureCustomText(
            text: model.user.username,
            color: .primaryBlack,
            isBold: true,
            size: 16
        )
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .primaryBlack
        button.setImage(UIImage(systemName: "chevron.compact.backward"), for: .normal)
        
        return button
    }()
    
    private lazy var collection: UICollectionView = {
        let collection: UICollectionView
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: 100, height: 50)
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.collectionView?.bounces = false
        collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.bounces = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CommentCell.self, forCellWithReuseIdentifier: "CommentCell")
        collection.isPagingEnabled = true
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .systemGreen
        return collection
    }()

    init(customView: CustomPostView = CustomPostView(frame: .zero), model: PostModel) {
        self.customView = customView
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        view.addSubview(scrollView)
        
        view.addSubview(topBar)
        topBar.addSubview(bottomLine)
        topBar.addSubview(barTitle)
        topBar.addSubview(backButton)
        
        
        
        
        customView.setupView(with: model)
        
        postView = customView
        postView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(containerView)
        containerView.addSubview(postView)
        containerView.addSubview(customView)
        containerView.addSubview(collection)
        
        setupConstraints()
        setupButtonAction()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.topAnchor.constraint(equalTo: view.topAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 132),

            bottomLine.leadingAnchor.constraint(equalTo: topBar.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: topBar.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: topBar.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1),

            barTitle.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            barTitle.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -12),

            backButton.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -12),
            backButton.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),

            scrollView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            postView.topAnchor.constraint(equalTo: containerView.topAnchor),
            postView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            postView.heightAnchor.constraint(equalToConstant: 610),

            collection.topAnchor.constraint(equalTo: postView.bottomAnchor, constant: 0),
            collection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collection.heightAnchor.constraint(equalToConstant: 700),

            collection.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

    private func setupButtonAction() {
        backButton.addAction(UIAction(handler: {[weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
    }
    
}


extension DetailsVC:  UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as? CommentCell
        let currentComment = model.comments[indexPath.row]
        cell?.configureCell(with: currentComment)
        return cell ?? CommentCell()
    }
}
