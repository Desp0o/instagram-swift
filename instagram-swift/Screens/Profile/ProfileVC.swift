//
//  ProfileVC.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

class ProfileVC: UIViewController {
    
    private var viewModel = ProfileViewModel()
    
    init(viewModel: ProfileViewModel  = ProfileViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var userNameViewWithIcon: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "", color: .black, isBold: true, size: 16)
        
        return label
    }()
    
    private lazy var privateIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "homeActive")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var profileInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var profilePictureView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.secondaryGray.cgColor
        view.layer.cornerRadius = 96 / 2
        
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 86 / 2
        
        return imageView
    }()
    
    private lazy var followInfoStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var viewForPost: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var numberOfpostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "14", color: .black, isBold: true, size: 16)
        
        return label
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "Post", color: .black, isBold: false, size: 13)
        
        return label
    }()
    
    private lazy var viewForFollowers: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var numberOfFollowersLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "834", color: .black, isBold: true, size: 16)
        
        return label
    }()
    
    private lazy var followersLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "Followers", color: .black, isBold: false, size: 13)
        
        return label
    }()
    
    private lazy var viewForFollowing: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var numberOfFollowigLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "162", color: .black, isBold: true, size: 16)
        
        return label
    }()
    
    private lazy var followingLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "Following", color: .black, isBold: false, size: 13)
        
        return label
    }()
    
    private lazy var bioStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "", color: .black, isBold: true, size: 12)
        
        return label
    }()
    
    private lazy var linkLabel: UILabel = {
        let linkLabel = UILabel()
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        linkLabel.configureCustomText(text: "", color: .black, isBold: false, size: 12)
        
        return linkLabel
    }()
    
    private lazy var bioLabel: UILabel = {
        let biolabel = UILabel()
        biolabel.translatesAutoresizingMaskIntoConstraints = false
        biolabel.configureCustomText(text: "", color: .black, isBold: false, size: 12)
        
        return biolabel
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.secondaryGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    private lazy var postsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let padding: CGFloat = 2
        let numberOfItemsPerRow: CGFloat = 3
        
        let availableWidth = UIScreen.main.bounds.width - (padding * (numberOfItemsPerRow - 1))
        let cellWidth = availableWidth / numberOfItemsPerRow
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        
        let collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectioView.translatesAutoresizingMaskIntoConstraints = false
        
        collectioView.dataSource = self
        collectioView.delegate = self
        collectioView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "PostCollectionViewCell")
        
        return collectioView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setValuesToLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        editButtonAction()
        viewModel.delegate = self
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(userNameViewWithIcon)
        userNameViewWithIcon.addSubview(userName)
        userNameViewWithIcon.addSubview(privateIcon)
        view.addSubview(profileInfoView)
        profileInfoView.addSubview(profilePictureView)
        profilePictureView.addSubview(profileImage)
        view.addSubview(followInfoStackView)
        followInfoStackView.addArrangedSubview(viewForPost)
        followInfoStackView.addArrangedSubview(viewForFollowers)
        followInfoStackView.addArrangedSubview(viewForFollowing)
        viewForPost.addSubview(postLabel)
        viewForPost.addSubview(numberOfpostLabel)
        viewForFollowers.addSubview(followersLable)
        viewForFollowers.addSubview(numberOfFollowersLable)
        viewForFollowing.addSubview(followingLable)
        viewForFollowing.addSubview(numberOfFollowigLable)
        profileInfoView.addSubview(bioStackView)
        bioStackView.addArrangedSubview(fullNameLabel)
        bioStackView.addArrangedSubview(linkLabel)
        bioStackView.addArrangedSubview(bioLabel)
        view.addSubview(editProfileButton)
        view.addSubview(postsCollectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            userNameViewWithIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userNameViewWithIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            privateIcon.heightAnchor.constraint(equalToConstant: 11.75),
            privateIcon.widthAnchor.constraint(equalToConstant: 8.75),
            privateIcon.leftAnchor.constraint(equalTo: userNameViewWithIcon.leftAnchor),
            privateIcon.topAnchor.constraint(equalTo: userNameViewWithIcon.topAnchor, constant: 4),
            privateIcon.bottomAnchor.constraint(equalTo: userNameViewWithIcon.bottomAnchor, constant: -4)
        ])
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: userNameViewWithIcon.topAnchor),
            userName.leftAnchor.constraint(equalTo: privateIcon.rightAnchor, constant: 6),
            userName.rightAnchor.constraint(equalTo: userNameViewWithIcon.rightAnchor),
            userName.bottomAnchor.constraint(equalTo: userNameViewWithIcon.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileInfoView.topAnchor.constraint(equalTo: userNameViewWithIcon.bottomAnchor, constant: 11),
            profileInfoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            profileInfoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
            
        ])
        
        NSLayoutConstraint.activate([
            profilePictureView.topAnchor.constraint(equalTo: profileInfoView.topAnchor),
            profilePictureView.leftAnchor.constraint(equalTo: profileInfoView.leftAnchor),
            profilePictureView.heightAnchor.constraint(equalToConstant: 96),
            profilePictureView.widthAnchor.constraint(equalTo: profilePictureView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 86),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor, multiplier: 1),
            profileImage.centerXAnchor.constraint(equalTo: profilePictureView.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: profilePictureView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            followInfoStackView.topAnchor.constraint(equalTo: profileInfoView.topAnchor, constant: 30),
            followInfoStackView.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 35),
            followInfoStackView.rightAnchor.constraint(equalTo: profileInfoView.rightAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            numberOfpostLabel.topAnchor.constraint(equalTo: viewForPost.topAnchor),
            numberOfpostLabel.centerXAnchor.constraint(equalTo: viewForPost.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            postLabel.topAnchor.constraint(equalTo: numberOfpostLabel.bottomAnchor, constant: 4),
            postLabel.bottomAnchor.constraint(equalTo: viewForPost.bottomAnchor),
            postLabel.centerXAnchor.constraint(equalTo: viewForPost.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            numberOfFollowersLable.topAnchor.constraint(equalTo: viewForFollowers.topAnchor),
            numberOfFollowersLable.centerXAnchor.constraint(equalTo: viewForFollowers.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            followersLable.topAnchor.constraint(equalTo: numberOfFollowersLable.bottomAnchor, constant: 4),
            followersLable.bottomAnchor.constraint(equalTo: viewForFollowers.bottomAnchor),
            followersLable.centerXAnchor.constraint(equalTo: viewForFollowers.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            numberOfFollowigLable.topAnchor.constraint(equalTo: viewForFollowing.topAnchor),
            numberOfFollowigLable.centerXAnchor.constraint(equalTo: viewForFollowing.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            followingLable.topAnchor.constraint(equalTo: numberOfFollowigLable.bottomAnchor, constant: 4),
            followingLable.bottomAnchor.constraint(equalTo: viewForFollowing.bottomAnchor),
            followingLable.centerXAnchor.constraint(equalTo: viewForFollowing.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bioStackView.topAnchor.constraint(equalTo: profilePictureView.bottomAnchor, constant: 12),
            bioStackView.leftAnchor.constraint(equalTo: profileInfoView.leftAnchor),
            bioStackView.bottomAnchor.constraint(equalTo: profileInfoView.bottomAnchor),
            bioStackView.rightAnchor.constraint(equalTo: profileInfoView.rightAnchor),
            bioStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            fullNameLabel.leftAnchor.constraint(equalTo: bioStackView.leftAnchor),
            
            linkLabel.leftAnchor.constraint(equalTo: bioStackView.leftAnchor),
            
            bioLabel.leftAnchor.constraint(equalTo: bioStackView.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            editProfileButton.topAnchor.constraint(equalTo: profileInfoView.bottomAnchor, constant: 15),
            editProfileButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            editProfileButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            postsCollectionView.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 26),
            postsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            postsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            postsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func editButtonAction() {
        editProfileButton.addAction(UIAction(handler: { [weak self] _ in
            let vc = ProfileSettingsVC()
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
    }
    
    private func setValuesToLabels() {
        userName.text = viewModel.username
        fullNameLabel.text = viewModel.name
        bioLabel.text = viewModel.bio
        linkLabel.text = viewModel.link
    }
    
    func didFinishFetchingData() {
        postsCollectionView.reloadData()
    }
}

extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as? PostCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let currentPost = viewModel.singlePost(with: indexPath.row),
           let imageUrlString = currentPost.images.first,
           let imageUrl = URL(string: imageUrlString) {
            cell.postImage.imageFrom(url: imageUrl)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currentPost = viewModel.singlePost(with: indexPath.row) {
            navigationController?.pushViewController(DetailsVC( model: currentPost), animated: true)
        }
    }
}

extension ProfileVC: ProfileViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
}
