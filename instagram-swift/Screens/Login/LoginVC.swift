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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(instagramLabel)
        
        NSLayoutConstraint.activate([
            instagramLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instagramLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 20)
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
