//
//  ProfileSettingsViewModel.swift
//  instagram-swift
//
//  Created by nino on 11/23/24.
//

import Foundation

class ProfileSettingsViewModel {
    
    private let nameKey = "Jacob West"
    private let usernameKey = "Jacob_w"
    private let bioKey = "Everything is designed"
    private let linksKey = "Digital goodies designer @pixsellz"
    
    var name: String
    var username: String
    var bio: String
    var link: String
    
    init() {
        self.name = UserDefaults.standard.string(forKey: nameKey) ?? "Jacob West"
        self.username = UserDefaults.standard.string(forKey: usernameKey) ?? "Jacob_w"
        self.bio = UserDefaults.standard.string(forKey: bioKey) ?? "Everything is designed"
        self.link = UserDefaults.standard.string(forKey: linksKey) ?? "Digital goodies designer @pixsellz"
    }
    
    func saveProfileInfo(name: String, username: String, bio: String, link: String) {
        UserDefaults.standard.set(name, forKey: nameKey)
        UserDefaults.standard.set(username, forKey: usernameKey)
        UserDefaults.standard.set(bio, forKey: bioKey)
        UserDefaults.standard.set(link, forKey: linksKey)
    }
}
