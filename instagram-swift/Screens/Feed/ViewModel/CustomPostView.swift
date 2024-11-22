//
//  CustomPostView.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

class CustomPostView: UIView {
    var model: PostModel?
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
        image.backgroundColor = .clear
        image.image = UIImage(named: "Rectangle")
        image.contentMode = .scaleToFill
        
        return image
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
    
    override init(frame: CGRect) {
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
        
        postView.addArrangedSubview(postImage)
        
        postView.addArrangedSubview(paginationStack)
        paginationStack.addArrangedSubview(iconStack)
        paginationStack.addArrangedSubview(bulletsStack)
        paginationStack.addArrangedSubview(emptyView)
        
        postView.addArrangedSubview(likesCountStack)
        likesCountStack.addArrangedSubview(lastLikedAvatar)
        likesCountStack.addArrangedSubview(lastPersonLieked)
        
        setupTabUserAvatar()
        setupConstraints()
        setupIconStack()
        setupBulletStack()
        setupLastLikedStack()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for postView
            postView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            postView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            postView.widthAnchor.constraint(equalTo: self.widthAnchor),
            postView.bottomAnchor.constraint(equalTo: likesCountStack.bottomAnchor),
            
            // Constraints for postUserTab
            postUserTab.topAnchor.constraint(equalTo: postView.topAnchor, constant: 0),
            postUserTab.widthAnchor.constraint(equalTo: postView.widthAnchor),
            postUserTab.heightAnchor.constraint(equalToConstant: 58),
            
            userAvatar.centerYAnchor.constraint(equalTo: postUserTab.centerYAnchor),
            userAvatar.leadingAnchor.constraint(equalTo: postUserTab.leadingAnchor, constant: 10),
            userAvatar.heightAnchor.constraint(equalToConstant: 32),
            userAvatar.widthAnchor.constraint(equalToConstant: 32),
            
            userInfoStack.centerYAnchor.constraint(equalTo: postUserTab.centerYAnchor),
            userInfoStack.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 10),
            
            // Constraints for postImage
            postImage.topAnchor.constraint(equalTo: postUserTab.bottomAnchor, constant: 0),
            postImage.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 0),
            postImage.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: 0),
            postImage.bottomAnchor.constraint(equalTo: paginationStack.topAnchor),
            
            // Constraints for paginationStack
            paginationStack.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 0),
            paginationStack.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: 0),
            
            // Constraints for likesCountStack
            likesCountStack.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 0),
            likesCountStack.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: 0),
            likesCountStack.bottomAnchor.constraint(equalTo: postView.bottomAnchor),
            
            // Constraints for lastLikedAvatar
            lastLikedAvatar.heightAnchor.constraint(equalToConstant: 18),
            lastLikedAvatar.widthAnchor.constraint(equalToConstant: 18),
            
        ])
    }
    
    private func setupTabUserAvatar() {
        layoutIfNeeded()
        
        userAvatar.layer.cornerRadius = userAvatar.frame.width / 2
    }
    
    private func setupIconStack() {
        let iconsArray = ["heartInactive", "Comment", "Messanger"]
        
        for icon in iconsArray {
            let iconButton = UIButton()
            
            iconButton.setImage(UIImage(named: icon), for: .normal)
            iconStack.addArrangedSubview(iconButton)
        }
    }
    
    private func setupBulletStack() {
        for _ in 0..<3 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBlue
            
            view.widthAnchor.constraint(equalToConstant: 10).isActive = true
            view.heightAnchor.constraint(equalToConstant: 10).isActive = true
            
            view.clipsToBounds = true
            view.layer.cornerRadius = 5
            bulletsStack.addArrangedSubview(view)
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
    
    func setupView(with model: PostModel) {
        userName.text = "\(model.user.username)"
        location.text = model.location
        lastLikedName.text = model.likes.lastLikedBy
        likeCount.text = "\(model.likes.likeCounts)"
        
        guard let url = URL(string: model.user.profilePicture) else { return }
        userAvatar.imageFrom(url: url)
        userAvatar.layer.cornerRadius = 16
    }
}


