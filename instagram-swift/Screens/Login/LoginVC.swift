//
//  LoginVC.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//
import SwiftUI
import UIKit

class LoginVC: UIViewController {
    
    private lazy var instagramLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureCustomText(text: "Instagram", color: .primaryBlack, isBold: false, size: 50)
        label.font = UIFont(name: "SnellRoundhand", size: 50)
        return label
    }()
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .customGray
        textField.placeholder = "Phone number, username or email address"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textAlignment = .center
        textField.layer.cornerRadius = 5
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.textAlignment = .center
        textField.backgroundColor = .customGray
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.cornerRadius = 5
        return textField
    }()
    private lazy var forgottenPasswordbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgotten password ?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.customBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .heavy)
        return button
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5
        button.backgroundColor = .customBlue
        return button
    }()
    private lazy var leftThinLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var righThinLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "OR"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray4
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(instagramLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgottenPasswordbutton)
        view.addSubview(loginButton)
        view.addSubview(leftThinLine)
        view.addSubview(righThinLine)
        view.addSubview(orLabel)
        
        NSLayoutConstraint.activate([
            instagramLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instagramLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 20),
             
            usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            usernameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            usernameTextField.topAnchor.constraint(equalTo: instagramLabel.bottomAnchor, constant: 30),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.leftAnchor.constraint(equalTo: usernameTextField.leftAnchor),
            passwordTextField.rightAnchor.constraint(equalTo: usernameTextField.rightAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),
            
            forgottenPasswordbutton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            forgottenPasswordbutton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor),
            
            loginButton.leftAnchor.constraint(equalTo: usernameTextField.leftAnchor),
            loginButton.rightAnchor.constraint(equalTo: usernameTextField.rightAnchor),
            loginButton.topAnchor.constraint(equalTo: forgottenPasswordbutton.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),
            
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            
            leftThinLine.leftAnchor.constraint(equalTo: usernameTextField.leftAnchor),
            leftThinLine.rightAnchor.constraint(equalTo: orLabel.leftAnchor, constant: -20),
            leftThinLine.heightAnchor.constraint(equalToConstant: 2),
            leftThinLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),
            
            righThinLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),
            righThinLine.rightAnchor.constraint(equalTo: usernameTextField.rightAnchor),
            righThinLine.leftAnchor.constraint(equalTo: orLabel.rightAnchor, constant: 20),
            righThinLine.heightAnchor.constraint(equalTo: leftThinLine.heightAnchor)
        ])
    }
}


struct viewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = LoginVC
    
    
    func makeUIViewController(context: Context) -> LoginVC {
        LoginVC()
    }
    
    func updateUIViewController(_ uiViewController: LoginVC, context: Context) {
        
    }
}

struct viewController_Previews: PreviewProvider {
    static var previews: some View {
        viewControllerRepresentable()
    }
}
