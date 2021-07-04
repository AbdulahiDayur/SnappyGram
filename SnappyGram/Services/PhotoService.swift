//
//  PhotoService.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 7/3/21.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class PhotoService {
    
    static func savePhoto(image: UIImage) {
        
        // Check that there's a user logged in
        if Auth.auth().currentUser == nil {
            return
        }
        
        // Get the data representation
        let photoData = image.jpegData(compressionQuality: 0.1)
        
        guard photoData != nil else {
            return
        }
        
        // Create a filename
        let filename = UUID().uuidString
        
        // Get current user id
        let userId = Auth.auth().currentUser!.uid
        
        // Create a firebase storage path
        let ref = Storage.storage().reference().child("images\(userId)/\(filename).jpg")
        
        // upload data
        ref.putData(photoData!, metadata: nil) { (meta, error) in
            
            // Check if upload was successful
            if error == nil {
                
                // Create database entry
                createDatabaseEntry(ref: ref)
            }
        }
    }
    
    
    private static func createDatabaseEntry(ref: StorageReference) {
        
        ref.downloadURL { (url, error) in
            
            if error == nil {
                
                let photoId = ref.fullPath
                
                // Current user
                let photoUser = LocalStorageService.loadUser()
                
                let userId = photoUser?.userId
                let username = photoUser?.userName
                
                // Date
                let df = DateFormatter()
                df.dateStyle = .full
                
                let dateString = df.string(from: Date())
                
                // Create dict of photo metaData
                let metaData = ["photoId": photoId, "byId": userId!, "byUsername": username!, "date": dateString, "url": url!.absoluteString]
                
                // Save the metaData to Firestore database
                let db = Firestore.firestore()
                
                db.collection("photos").addDocument(data: metaData) { (error) in
                    
                    if error == nil {
                        
                    }
                }
            }
        }
    }
}
