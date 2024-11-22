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
            passwordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor)
            
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
