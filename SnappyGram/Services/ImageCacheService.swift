//
//  ImageCacheService.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 7/7/21.
//

import Foundation
import UIKit

class ImageCacheService {
    
    static var imageCache = [String: UIImage]()
    
    static func saveImage(url: String?, image: UIImage?) {
        
        // Check against nil
        if url == nil || image == nil {
            return
        }
        
        // Save the image
        imageCache[url!] = image!
    }
    
    static func getImage(url: String?) -> UIImage? {
        
        if url == nil {
            return nil
        }
        
        return imageCache[url!]
    }
}
