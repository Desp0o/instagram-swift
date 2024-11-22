//
//  LoginVC.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

class LoginVC: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .taggedBlue
        navigationController?.isNavigationBarHidden = true
        
        setupButton()
    }
    
    private func setupButton() {
        button.setTitle("go to feed", for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.handleLogin()
        }), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func handleLogin() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = TabBarController()
    }
}
