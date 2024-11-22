//
//  LoginViewModel.swift
//  instagram-swift
//
//  Created by Giorgi Gakhokidze on 22.11.24.
//

import Foundation
import UIKit

class LoginViewModel {
    
    private let usernameKey = "user123"
    private let passwordKey = "pass123"
    
    var username: String?
    var password: String?
    var confirmPassword: String?
    var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func saveCredentials(username: String, password: String) {
        KeyChainManager.shared.save(Data(username.utf8), account: usernameKey)
        KeyChainManager.shared.save(Data(password.utf8), account: passwordKey)
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
    
    func loadCredentials() {
        guard isLoggedIn else { return }
        
        if let usernameData = KeyChainManager.shared.read(account: usernameKey),
           let passwordData = KeyChainManager.shared.read(account: passwordKey) {
            username = String(data: usernameData, encoding: .utf8)
            password = String(data: passwordData, encoding: .utf8)
        }
    }

    func handleLogin(username: String, password: String, confirmPassword: String) -> Bool {
        guard password == confirmPassword else {
            return false
        }
        saveCredentials(username: username, password: password)
        return true
    }
}
