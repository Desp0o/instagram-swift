//
//  ProfileViewModel.swift
//  instagram-swift
//
//  Created by nino on 11/24/24.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func reloadData()
}

class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    
    private let nameKey = "nameKey"
    private let usernameKey = "usernameKey"
    private let bioKey = "bioKey"
    private let linksKey = "linksKey"
    
    var name: String {
        return UserDefaults.standard.string(forKey: nameKey) ?? "Jacob West"
    }
    
    var username: String {
        return UserDefaults.standard.string(forKey: usernameKey) ?? "Jacob_w"
    }
    
    var bio: String {
        return UserDefaults.standard.string(forKey: bioKey) ?? "Everything is designed"
    }
    
    var link: String {
        return UserDefaults.standard.string(forKey: linksKey) ?? "Digital goodies designer @pixsellz"
    }
    
}

