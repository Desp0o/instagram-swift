//
//  ProfileVC.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

class ProfileSettingsVC: UIViewController {
    
    private var viewModel = ProfileSettingsViewModel()
    
    var headerlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "Edit Profile", color: .black, isBold: true, size: 16)
        
        return label
    }()
    
    var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondaryGray
        
        return view
    }()
    
    var profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "profilePicture")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 43
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var changePicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "Edit profile Picture", color: .customBlue, isBold: true, size: 12)
        
        return label
    }()
    
    var lineViewAfterPic: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondaryGray
        
        return view
    }()
    
    var userInfoStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.alignment = .center
        
        return stackView
    }()
    
    var nameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "Name", color: .black, isBold: false, size: 16)
        
        return label
    }()
    
    var nameTaxtField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.isEnabled = true
        textField.returnKeyType = .next
        textField.isUserInteractionEnabled = true
        textField.text = "Jacob West"

        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black

        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.black.cgColor
        bottomLine.frame = CGRect(x: 0, y: 30, width: 250  , height: 0.5)
        textField.layer.addSublayer(bottomLine)

        return textField
    }()
    
    var userNameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "Username", color: .black, isBold: false, size: 16)
        
        return label
    }()
    
    var userNameTaxtField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.returnKeyType = .next
        textField.text = "Jacob_w"

        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black

        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.black.cgColor
        bottomLine.frame = CGRect(x: 0, y: 30, width: 250  , height: 0.5)
        textField.layer.addSublayer(bottomLine)

        return textField
    }()
    
    var bioView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "Bio", color: .black, isBold: false, size: 16)
        
        return label
    }()
    
    var bioTaxtField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.returnKeyType = .next
        textField.text = "Everything is designed"

        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black

        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.black.cgColor
        bottomLine.frame = CGRect(x: 0, y: 30, width: 250  , height: 0.5)
        textField.layer.addSublayer(bottomLine)

        return textField
    }()
    
    var linkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var linkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "Link", color: .black, isBold: false, size: 16)
        
        return label
    }()
    
    var linkTaxtField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.returnKeyType = .next
        textField.text = "Digital goodies designer @pixsellz"

        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black

        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.black.cgColor
        bottomLine.frame = CGRect(x: 0, y: 30, width: 250  , height: 0.5)
        textField.layer.addSublayer(bottomLine)

        return textField
    }()
    
    var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.customBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.style = .none
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        saveData()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(headerlabel)
        view.addSubview(doneButton)
        view.addSubview(lineView)
        view.addSubview(profilePicture)
        view.addSubview(changePicLabel)
        view.addSubview(lineViewAfterPic)
        view.addSubview(userInfoStackView)
        userInfoStackView.addArrangedSubview(nameView)
        userInfoStackView.addArrangedSubview(userNameView)
        userInfoStackView.addArrangedSubview(bioView)
        userInfoStackView.addArrangedSubview(linkView)
        nameView.addSubview(nameLabel)
        nameView.addSubview(nameTaxtField)
        userNameView.addSubview(userNameLabel)
        userNameView.addSubview(userNameTaxtField)
        bioView.addSubview(bioLabel)
        bioView.addSubview(bioTaxtField)
        linkView.addSubview(linkLabel)
        linkView.addSubview(linkTaxtField)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            headerlabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: headerlabel.topAnchor, constant: -5),
            doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: headerlabel.bottomAnchor, constant: 10),
            lineView.leftAnchor.constraint(equalTo: view.leftAnchor),
            lineView.rightAnchor.constraint(equalTo: view.rightAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            profilePicture.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePicture.heightAnchor.constraint(equalToConstant: 86),
            profilePicture.widthAnchor.constraint(equalTo: profilePicture.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            changePicLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 10),
            changePicLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lineViewAfterPic.topAnchor.constraint(equalTo: changePicLabel.bottomAnchor, constant: 10),
            lineViewAfterPic.leftAnchor.constraint(equalTo: view.leftAnchor),
            lineViewAfterPic.rightAnchor.constraint(equalTo: view.rightAnchor),
            lineViewAfterPic.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            userInfoStackView.topAnchor.constraint(equalTo: lineViewAfterPic.bottomAnchor, constant: 30),
            userInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userInfoStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nameView.heightAnchor.constraint(equalToConstant: 40),
            nameView.leadingAnchor.constraint(equalTo: userInfoStackView.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: userInfoStackView.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: nameView.leftAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameTaxtField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
              nameTaxtField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor),
              nameTaxtField.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
              nameTaxtField.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            userNameView.heightAnchor.constraint(equalToConstant: 40),
            userNameView.leadingAnchor.constraint(equalTo: userInfoStackView.leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: userInfoStackView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.leftAnchor.constraint(equalTo: userNameView.leftAnchor),
            userNameLabel.centerYAnchor.constraint(equalTo: userNameView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userNameTaxtField.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 20),
            userNameTaxtField.trailingAnchor.constraint(equalTo: userNameView.trailingAnchor),
            userNameTaxtField.centerYAnchor.constraint(equalTo: userNameView.centerYAnchor),
            userNameTaxtField.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        NSLayoutConstraint.activate([
            bioView.heightAnchor.constraint(equalToConstant: 40),
            bioView.leadingAnchor.constraint(equalTo: userInfoStackView.leadingAnchor),
            bioView.trailingAnchor.constraint(equalTo: userInfoStackView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bioLabel.leftAnchor.constraint(equalTo: bioView.leftAnchor),
            bioLabel.centerYAnchor.constraint(equalTo: bioView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bioTaxtField.leadingAnchor.constraint(equalTo: bioLabel.trailingAnchor, constant: 20),
            bioTaxtField.trailingAnchor.constraint(equalTo: bioView.trailingAnchor),
            bioTaxtField.centerYAnchor.constraint(equalTo: bioView.centerYAnchor),
            bioTaxtField.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            linkView.heightAnchor.constraint(equalToConstant: 40),
            linkView.leadingAnchor.constraint(equalTo: userInfoStackView.leadingAnchor),
            linkView.trailingAnchor.constraint(equalTo: userInfoStackView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            linkLabel.leftAnchor.constraint(equalTo: linkView.leftAnchor),
            linkLabel.centerYAnchor.constraint(equalTo: linkView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            linkTaxtField.leadingAnchor.constraint(equalTo: linkLabel.trailingAnchor, constant: 20),
            linkTaxtField.trailingAnchor.constraint(equalTo: linkView.trailingAnchor),
            linkTaxtField.centerYAnchor.constraint(equalTo: linkView.centerYAnchor),
            linkTaxtField.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func saveData() {
        nameTaxtField.text = viewModel.name
        userNameTaxtField.text = viewModel.username
        bioTaxtField.text = viewModel.bio
        linkTaxtField.text = viewModel.link
        
        doneButton.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.saveProfileInfo(name: self?.nameTaxtField.text ?? "",
                                            username: self?.userNameTaxtField.text ?? "",
                                            bio: self?.bioTaxtField.text ?? "",
                                            link: self?.linkTaxtField.text ?? "")
            self?.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
    }
}
