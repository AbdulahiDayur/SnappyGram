//
//  LocalStorageService.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 6/30/21.
//

import Foundation

class LocalStorageService {
    
    static func saveUser(userId: String?, username: String?) {
        
        // Get a reference to user defaults
        let defaults = UserDefaults.standard
        
        // Save the userId and username to defaults
        defaults.set(userId, forKey: Constants.LocalStorage.userIdKey)
        defaults.set(username, forKey: Constants.LocalStorage.usernameKey)
    }
}
