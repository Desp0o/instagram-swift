//
//  CommentCell.swift
//  instagram-swift
//
//  Created by Despo on 24.11.24.
//

import UIKit

class CommentCell: UICollectionViewCell {
    private lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var commentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var userComment: UILabel = {
        let label = UILabel()
        
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
        contentView.addSubview(avatar)
        contentView.addSubview(commentStack)
        
        commentStack.addArrangedSubview(userName)
        commentStack.addArrangedSubview(userComment)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            avatar.widthAnchor.constraint(equalToConstant: 36),
            avatar.heightAnchor.constraint(equalToConstant: 36),
            
            commentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            commentStack.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10),
            
            userComment.leadingAnchor.constraint(equalTo: commentStack.leadingAnchor, constant: 0),
            userComment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func configureCell(with comment: Comment) {
        guard let url = URL(string: comment.profilePicture) else {  return }
        
        avatar.imageFrom(url: url)
        avatar.layer.cornerRadius = 18
        
        userName.configureCustomText(text: comment.username, color: .primaryBlack, isBold: true, size: 13)
        userComment.configureCustomText(text: comment.comment, color: .primaryBlack, isBold: false, size: 13)
    }
}
