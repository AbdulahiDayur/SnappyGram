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
    
    static func loadUser() -> PhotoUser? {
        
        let defaults = UserDefaults.standard
        
        // Get username and id
        let userId = defaults.value(forKey: Constants.LocalStorage.userIdKey) as? String
        let username = defaults.value(forKey: Constants.LocalStorage.usernameKey) as? String
        
        // return saved user
        if userId != nil && username != nil {
            return PhotoUser(userId: userId, userName: username)
        }
        
        return nil
    }
    
    static func clearUser() {
        let defaults = UserDefaults.standard
        
        // Clear the values for the keys
        defaults.set(nil, forKey: Constants.LocalStorage.userIdKey)
        defaults.set(nil, forKey: Constants.LocalStorage.usernameKey)
    }
}
