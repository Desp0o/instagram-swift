//
//  KeyChainManager.swift
//  instagram-swift
//
//  Created by Giorgi Gakhokidze on 22.11.24.
//

import Foundation
import UIKit

class KeyChainManager {
 
    static let shared = KeyChainManager()
    
    func save(_ data: Data, service: String, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: data
        ] as CFDictionary
        
        SecItemDelete(query)
        SecItemAdd(query, nil)
    }
    
    func read(service: String, account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return result as? Data
    }

}
