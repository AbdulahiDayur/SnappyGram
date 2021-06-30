//
//  UserService.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 6/28/21.
//

import Foundation
import FirebaseFirestore

class UserService {
    
    static func createProfile(userId: String, username: String, completion: @escaping (PhotoUser?) -> Void) {
        
        let profileData = ["username": username]
        
        let db = Firestore.firestore()
        
        // Create document for userId
        db.collection("users").document(userId).setData(profileData) { (error) in
            
            if error == nil {
                // Profile successfully created
                var u = PhotoUser()
                u.userName = username
                u.userId = userId
                
                completion(u)
                
            } else {
                // something went wrong
                completion(nil)
                
            }
        }
    }
    
    static func retrieveProfile(userId: String, completion: @escaping (PhotoUser?) -> Void) {
        
        // Get fireBase reference
        let db = Firestore.firestore()
        
        // Check for a profile given the user id
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            
            if error != nil || snapshot == nil {
                return
            }
            
            if let profile = snapshot!.data() {
                
                // Create a new Photo user                
                var u = PhotoUser()
                u.userId = snapshot!.documentID
                u.userName = profile["username"] as? String
                
                completion(u)
                
            } else {
                
                completion(nil)
                
            }
        }
        
        
    }
}
