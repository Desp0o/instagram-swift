//
//  CustomPostView.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit
import Foundation

class CustomPostView: UIView {
    var model: PostModel?
    var toggler = false
    private let postViewModel: PostViewModel
    
    private let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var postView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    private lazy var postUserTab: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var userAvatar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var userInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 1
        
        return stack
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.configureCustomText(text: "", color: .primaryBlack, isBold: true, size: 13)
        
        return label
    }()
    
    private lazy var location: UILabel = {
        let label = UILabel()
        label.configureCustomText(text: "", color: .primaryBlack, isBold: false, size: 11)
        
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.image = UIImage(named: "Rectangle")
        image.contentMode = .scaleToFill
        
        return image
    }()
    
    private lazy var collection: UICollectionView = {
        let collection: UICollectionView
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: 100, height: 406)
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.collectionView?.bounces = false
        collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.bounces = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CarouselCell.self, forCellWithReuseIdentifier: "CarouselCell")
        collection.isPagingEnabled = true
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    private lazy var imageCounterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 12
        //        view.isHidden = true
        return view
    }()
    
    private lazy var imageCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private lazy var paginationStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 58
        
        return stack
    }()
    
    private lazy var iconStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 18
        return stack
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = iconStack.arrangedSubviews.count
        
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.likePost()
        }), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = iconStack.arrangedSubviews.count
        button.setImage(UIImage(named:"Comment"), for: .normal)
        
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.showComments()
        }), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = iconStack.arrangedSubviews.count
        button.setImage(UIImage(named:"Messanger"), for: .normal)
        
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let model = self?.model else { return }
            self?.share(post: model)
        }), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var bulletsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    private lazy var likesCountStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        stack.distribution = .fill
        stack.spacing = 15
        
        return stack
    }()
    
    private lazy var lastLikedAvatar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "testUser")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var lastPersonLieked: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        
        return stack
    }()
    
    private lazy var lastLikedName: UILabel = {
        let label = UILabel()
        label.configureCustomText(text: "", color: .primaryBlack, isBold: true, size: 13)
        
        return label
    }()
    
    private lazy var likeCount: UILabel = {
        let label = UILabel()
        label.configureCustomText(text: "", color: .primaryBlack, isBold: true, size: 13)
        
        return label
    }()
    
    private lazy var commentStack: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var commentAuthor: UILabel = {
        let label = UILabel()
        label.configureCustomText(text: "", color: .primaryBlack, isBold: true, size: 13)
        
        return label
    }()
    
    private lazy var postDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var postDate: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var currentPage: Int = 0 {
        didSet {
            updateBullets()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: postView.frame.width, height: 406)
        }
    }
    
    init(frame: CGRect, postViewModel: PostViewModel = PostViewModel()) {
        self.postViewModel = postViewModel
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        addSubview(postView)
        postView.addArrangedSubview(postUserTab)
        
        postUserTab.addSubview(userAvatar)
        postUserTab.addSubview(userInfoStack)
        
        userInfoStack.addArrangedSubview(userName)
        userInfoStack.addArrangedSubview(location)
        
        postView.addArrangedSubview(collection)
        collection.addSubview(imageCounterView)
        imageCounterView.addSubview(imageCounterLabel)
        
        postView.addArrangedSubview(paginationStack)
        paginationStack.addArrangedSubview(iconStack)
        paginationStack.addArrangedSubview(bulletsStack)
        paginationStack.addArrangedSubview(emptyView)
        iconStack.addArrangedSubview(likeButton)
        iconStack.addArrangedSubview(commentButton)
        iconStack.addArrangedSubview(shareButton)
        
        postView.addArrangedSubview(likesCountStack)
        likesCountStack.addArrangedSubview(lastLikedAvatar)
        likesCountStack.addArrangedSubview(lastPersonLieked)
        
        postView.addSubview(commentStack)
        postView.addSubview(postDate)
        commentStack.addSubview(postDescription)
        
        setupTabUserAvatar()
        setupConstraints()
        setupLastLikedStack()
        collection.reloadData()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            postView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            postView.widthAnchor.constraint(equalTo: self.widthAnchor),
            postView.bottomAnchor.constraint(equalTo: likesCountStack.bottomAnchor),
            
            postUserTab.topAnchor.constraint(equalTo: postView.topAnchor, constant: 0),
            postUserTab.widthAnchor.constraint(equalTo: postView.widthAnchor),
            postUserTab.heightAnchor.constraint(equalToConstant: 58),
            
            userAvatar.centerYAnchor.constraint(equalTo: postUserTab.centerYAnchor),
            userAvatar.leadingAnchor.constraint(equalTo: postUserTab.leadingAnchor, constant: 10),
            userAvatar.heightAnchor.constraint(equalToConstant: 32),
            userAvatar.widthAnchor.constraint(equalToConstant: 32),
            
            userInfoStack.centerYAnchor.constraint(equalTo: postUserTab.centerYAnchor),
            userInfoStack.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 10),
            
            collection.topAnchor.constraint(equalTo: postUserTab.bottomAnchor, constant: 0),
            collection.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 0),
            collection.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: 0),
            collection.bottomAnchor.constraint(equalTo: paginationStack.topAnchor),
            collection.heightAnchor.constraint(equalToConstant: 406),
            collection.widthAnchor.constraint(equalTo: postView.widthAnchor),
            
            imageCounterView.topAnchor.constraint(equalTo: collection.topAnchor, constant: 12),
            imageCounterView.trailingAnchor.constraint(equalTo: collection.trailingAnchor, constant: -12),
            imageCounterView.heightAnchor.constraint(equalToConstant: 24),
            imageCounterView.widthAnchor.constraint(greaterThanOrEqualToConstant: 45),
            
            imageCounterLabel.leadingAnchor.constraint(equalTo: imageCounterView.leadingAnchor, constant: 8),
            imageCounterLabel.trailingAnchor.constraint(equalTo: imageCounterView.trailingAnchor, constant: -8),
            imageCounterLabel.centerYAnchor.constraint(equalTo: imageCounterView.centerYAnchor),
            
            paginationStack.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 0),
            paginationStack.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: 0),
            
            bulletsStack.centerXAnchor.constraint(equalTo: paginationStack.centerXAnchor),
            
            likesCountStack.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 0),
            likesCountStack.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: 0),
            likesCountStack.bottomAnchor.constraint(equalTo: postView.bottomAnchor),
            
            lastLikedAvatar.heightAnchor.constraint(equalToConstant: 24),
            lastLikedAvatar.widthAnchor.constraint(equalToConstant: 24),
            
            commentStack.topAnchor.constraint(equalTo: likesCountStack.bottomAnchor, constant: 10),
            commentStack.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 15),
            postDescription.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 15),
            postDescription.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -15),
            
            postDate.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 10),
            postDate.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 15),
        ])
    }
    
    private func setupTabUserAvatar() {
        userAvatar.layer.cornerRadius = userAvatar.frame.width / 2
    }
    
    private func likePost() {
        guard var currentModel = model else { return }
        
        toggler.toggle()
        
        likeButton.setImage(
            UIImage(named: toggler ? "heartActive" : "heartInactive"),
            for: .normal
        )
        
        currentModel.isLiked = toggler
        
        model = currentModel
        
        postViewModel.likePost(postId: currentModel.postId, isLiked: currentModel.isLiked)
        
    }
    
    private func showComments() {
        guard let model = model else { return }
        let commentController = CommentsVC(commentsArray: model.comments)
        commentController.modalPresentationStyle = .pageSheet
        
        if let sheet = commentController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        if let viewController = findViewController() {
            viewController.present(commentController, animated: true)
        }
    }
    
    private func share(post: PostModel) {
        var activityItems: [Any] = []
        
        if let fakeURL = URL(string: "https://example.com/post/\(post.postId)") {
            activityItems.append(fakeURL)
        }
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        if let viewController = findViewController() {
            viewController.present(activityViewController, animated: true)
        }
    }
    
    private func setupBulletStack() {
        bulletsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let imageCount = model?.images.count, imageCount > 1 else { return }
        
        for i in 0..<imageCount {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = i == currentPage ? .systemBlue : .secondaryGray
            
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 8),
                view.heightAnchor.constraint(equalToConstant: 8)
            ])
            
            view.layer.cornerRadius = 4
            view.clipsToBounds = true
            bulletsStack.addArrangedSubview(view)
        }
    }
    
    static func configureView(with model: PostModel) -> CustomPostView {
        let viewController = CustomPostView(frame: .zero)
        viewController.model = model
        return viewController
    }
    
    private func updateBullets() {
        guard let imageCount = model?.images.count,
              imageCount > 1,
              bulletsStack.arrangedSubviews.count == imageCount else { return }
        
        for (index, view) in bulletsStack.arrangedSubviews.enumerated() {
            view.backgroundColor = index == currentPage ? .customBlue : .secondaryGray
        }
    }
    
    private func setupLastLikedStack() {
        let prefix = UILabel()
        let middleText = UILabel()
        let sufix = UILabel()
        let view = UIView()
        
        prefix.configureCustomText(text: "Liked by", color: .primaryBlack, isBold: false, size: 13)
        middleText.configureCustomText(text: "and", color: .primaryBlack, isBold: false, size: 13)
        sufix.configureCustomText(text: "others", color: .primaryBlack, isBold: false, size: 13)
        
        lastPersonLieked.addArrangedSubview(prefix)
        lastPersonLieked.addArrangedSubview(lastLikedName)
        lastPersonLieked.addArrangedSubview(middleText)
        lastPersonLieked.addArrangedSubview(likeCount)
        lastPersonLieked.addArrangedSubview(sufix)
        lastPersonLieked.addArrangedSubview(view)
    }
    
    private func updateImageCounter(page: Int) {
        guard let totalImages = model?.images.count else { return }
        imageCounterLabel.text = "\(page + 1)/\(totalImages)"
    }
    
    private func resetCollectionView() {
        currentPage = 0
        collection.scrollToItem(at: IndexPath(item: 0, section: 0),
                                at: .top,
                                animated: false)
    }
    
    func setupView(with model: PostModel) {
        self.model = model
        userName.text = model.user.username
        location.text = model.location
        lastLikedName.text = model.likes.lastLikedBy
        likeCount.text = "\(model.likes.likeCounts)"
        
        let likedPosts = postViewModel.loadPostsFromUserDefaults()
        let isLiked = likedPosts.first(where: { $0.postId == model.postId })?.isLiked ?? model.isLiked
        
        likeButton.setImage(UIImage(
            named: isLiked ? "heartActive" : "heartInactive"),
                            for: .normal
        )
        toggler = isLiked
        
        postDescription.configureCustomText(
            text: model.description,
            color: .primaryBlack,
            isBold: false,
            size: 13
        )
        
        postDate.configureCustomText(
            text: model.createdAt,
            color: .secondaryGray,
            isBold: false,
            size: 13
        )
        
        if let avatarUrl = URL(string: model.comments[0].profilePicture) {
            lastLikedAvatar.imageFrom(url: avatarUrl)
            lastLikedAvatar.layer.cornerRadius = 12
        }
        
        if let url = URL(string: model.user.profilePicture) {
            userAvatar.imageFrom(url: url)
        }
        userAvatar.layer.cornerRadius = 16
        
        imageCounterView.isHidden = (model.images.count <= 1)
        updateImageCounter(page: 2)
        
        setupBulletStack()
        collection.reloadData()
        resetCollectionView()
    }
}

extension CustomPostView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as? CarouselCell,
              let currentImage = model?.images[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: currentImage)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        currentPage = page
        updateImageCounter(page: page)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        updateImageCounter(page: page)
    }
}


extension UIView {
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let currentResponder = responder {
            if let viewController = currentResponder as? UIViewController {
                return viewController
            }
            responder = currentResponder.next
        }
        return nil
    }
}
