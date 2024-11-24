import UIKit

class LikeCollectionViewCell: UICollectionViewCell {
    static let identifier = "LikeCollectionViewCell"
    
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let actionLabel = UILabel()
    private let postImageView = UIImageView()
    private let followButton = UIButton(type: .system)
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.layer.cornerRadius = 5
        
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        usernameLabel.textColor = .black
        
        actionLabel.font = UIFont.systemFont(ofSize: 13)
        actionLabel.textColor = .darkGray
        
        timeLabel.font = UIFont.systemFont(ofSize: 11)
        timeLabel.textColor = .lightGray
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.backgroundColor = .systemBlue
        followButton.layer.cornerRadius = 5
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        let actionAndTimeStackView = UIStackView(arrangedSubviews: [actionLabel, timeLabel])
        actionAndTimeStackView.axis = .horizontal
        actionAndTimeStackView.spacing = 5
        actionAndTimeStackView.alignment = .center
        
        let labelsStackView = UIStackView(arrangedSubviews: [usernameLabel, actionAndTimeStackView])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        
        let mainStackView = UIStackView(arrangedSubviews: [profileImageView, labelsStackView, postImageView, followButton])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 10
        mainStackView.alignment = .center
        
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            postImageView.widthAnchor.constraint(equalToConstant: 50),
            postImageView.heightAnchor.constraint(equalToConstant: 50),
            
            followButton.widthAnchor.constraint(equalToConstant: 90),
            followButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with likeItem: LikeItem) {
        profileImageView.image = UIImage(named: likeItem.profileImage)
        
        usernameLabel.configureCustomText(
            text: likeItem.username,
            color: .black,
            isBold: true,
            size: 14,
            alignment: .left
        )
        
        actionLabel.configureCustomText(
            text: likeItem.action,
            color: .gray,
            isBold: false,
            size: 12,
            alignment: .left
        )
        
        timeLabel.text = likeItem.time
        
        if let postImage = likeItem.postImage {
            postImageView.image = UIImage(named: postImage)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        followButton.isHidden = !likeItem.isFollowButtonVisible
    }
    
}
