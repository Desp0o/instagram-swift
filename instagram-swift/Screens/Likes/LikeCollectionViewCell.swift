import UIKit

class LikeCollectionViewCell: UICollectionViewCell {
    static let identifier = "LikeCollectionViewCell"
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill

        return image
    }()
    
    private lazy var postImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var actionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var followButton: UIButton = {
        let button =  UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.addAction(UIAction(handler: {[weak self] _ in
            self?.didTapFollowButton()
        }), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()

        return label
    }()
    
    private lazy var actionAndTimeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        
        return stack
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        
        return stack
    }()
    
    private var isFollowing = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(profileImageView)
        mainStackView.addArrangedSubview(labelsStackView)
        mainStackView.addArrangedSubview(postImageView)
        mainStackView.addArrangedSubview(followButton)
        
        profileImageView.layer.cornerRadius = 20
        postImageView.layer.cornerRadius = 5
        
        labelsStackView.addArrangedSubview(usernameLabel)
        labelsStackView.addArrangedSubview(actionAndTimeStackView)
        
        actionAndTimeStackView.addArrangedSubview(actionLabel)
        actionAndTimeStackView.addArrangedSubview(timeLabel)
        
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            postImageView.widthAnchor.constraint(equalToConstant: 50),
            postImageView.heightAnchor.constraint(equalToConstant: 50),
            
            followButton.widthAnchor.constraint(equalToConstant: 90),
            followButton.heightAnchor.constraint(equalToConstant: 30),
            
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    private func didTapFollowButton() {
        isFollowing.toggle()
        
        if isFollowing {
            followButton.setTitle("Following", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .systemGray
            followButton.layer.borderColor = UIColor.black.cgColor
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .systemBlue
            followButton.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    
    func configure(with likeItem: LikeItem) {
        guard let url = URL(string: likeItem.profileImage) else {  return }
        profileImageView.imageFrom(url: url)
        
        usernameLabel.configureCustomText(
            text: likeItem.username,
            color: .black,
            isBold: true,
            size: 14,
            alignment: .left
        )
        
        actionLabel.configureCustomText(
            text: likeItem.action,
            color: .primaryBlack,
            isBold: false,
            size: 13,
            alignment: .left
        )
        
        timeLabel.configureCustomText(
            text: likeItem.time,
            color: .secondaryGray,
            isBold: false,
            size: 11,
            lineNumber: 1
        )
        
        if likeItem.postImage != nil {
            guard let url = URL(string: likeItem.postImage ?? "") else { return }
            postImageView.imageFrom(url: url)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        followButton.isHidden = !likeItem.isFollowButtonVisible
    }
}
