//
//  AddPostViewController.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

class AddPostVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }

}
