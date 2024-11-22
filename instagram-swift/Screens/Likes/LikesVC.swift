//
//  LikesVC.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

class LikesVC: UIViewController {
    private let topBar = UIView()
    private let barTitle = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true

        setupTopBar()
    }
    
    private func setupTopBar() {
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        
        topBar.backgroundColor = .tabBarCol
        
        NSLayoutConstraint.activate([
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topBar.heightAnchor.constraint(equalToConstant: 112)
        ])
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.secondaryGray
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        topBar.addSubview(bottomLine)
        
        NSLayoutConstraint.activate([
            bottomLine.leadingAnchor.constraint(equalTo: topBar.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: topBar.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: topBar.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        setupTopBarTitle()
    }
    
    private func setupTopBarTitle() {
        topBar.addSubview(barTitle)

        barTitle.configureCustomText(
            text: "You",
            color: .primaryBlack,
            isBold: true,
            size: 16
        )
        
        NSLayoutConstraint.activate([
            barTitle.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            barTitle.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -12)
        ])
    }
}
