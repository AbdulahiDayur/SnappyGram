//
//  Photo.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 7/3/21.
//

import Foundation
import FirebaseFirestore

struct Photo {
    
    var photoId: String?
    var byId: String?
    var byUsername: String?
    var date: String?
    var url: String?
    
    init? (snapshot: QueryDocumentSnapshot) {
        
        // Parse the data out
        let data = snapshot.data()
        
        let photoId = data["photoId"] as? String
        let userId = data["byId"] as? String
        let username = data["byUsername"] as? String
        let date = data["date"] as? String
        let url = data["url"] as? String
        
        if photoId == nil || userId == nil || username == nil || date == nil || url == nil {
            return nil
        }
        
        self.photoId = photoId
        self.byId = photoId
        self.byUsername = username
        self.date = date
        self.url = url
        
    }
    
}
