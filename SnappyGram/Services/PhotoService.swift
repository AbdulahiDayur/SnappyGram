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
    
    
    static func retrievePhotos(completion: @escaping ([Photo]) -> Void) {
        
        // Get a database reference
        let db = Firestore.firestore()
        
        // Get all the docs from photos collection
        db.collection("photos").getDocuments { (snapshot, error) in
            
            if error != nil {
                return
            }
            
            // Get all docs
            let documents = snapshot?.documents
            
            if let documents = documents {
                
                // Array to hold all Photo Structs
                var photoArray = [Photo]()
                
                // Create photo struct for each
                for doc in documents {
                    
                    // Parse the docs into photo structs
                    let p = Photo(snapshot: doc)
                    
                    if p != nil {
                        photoArray.insert(p!, at: 0)
                    }
                    
                }
                // Pass back photo Array
                completion(photoArray)
            }
        }
    }
    
    static func savePhoto(image: UIImage, progressUpdate: @escaping (Double) -> Void) {
        
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
        let uploadTask = ref.putData(photoData!, metadata: nil) { (meta, error) in
            
            // Check if upload was successful
            if error == nil {
                
                // Create database entry
                createDatabaseEntry(ref: ref)
            }
        }
        
        uploadTask.observe(.progress) { (taskSnapshot) in
            
            let pct = Double(taskSnapshot.progress!.completedUnitCount) / Double(taskSnapshot.progress!.totalUnitCount)
            print("this is taskSnapshot: \(taskSnapshot.progress!)")
            print("this is pct: \(pct)")
            
            progressUpdate(pct)
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
