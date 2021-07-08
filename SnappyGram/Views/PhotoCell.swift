//
//  PhotoCell.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 7/6/21.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    
    // This property will hold the photo this cell is currently displaying
    var photo: Photo?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayPhoto(photo: Photo) {
        
        // Reset image
        self.photoImageView.image = nil
        
        // Set photo property (keep track)
        self.photo = photo
        
        usernameLabel.text = photo.byUsername
        dateLabel.text = photo.date
        
        if photo.url == nil {
            return
        }
        
        // Download image
        let url = URL(string: photo.url!)
        
        if url == nil {
            return
        }
        
        // Check if the image is in our image cache
        if let cachedImage = ImageCacheService.getImage(url: photo.url!) {
            
            // Use the cached image
            self.photoImageView.image = cachedImage
            
            // Return because we no longer need to download image
            return
        }
        
        // Download image asynchronously
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                let image = UIImage(data: data!)
                
                // Store image data in cache
                ImageCacheService.saveImage(url: url!.absoluteString, image: image)
                
                // Check that the image data we downloaded matches the photo this cell is currently supposed to display
                if url!.absoluteString != self.photo?.url {
                    return
                }
                
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
            }
        }
        dataTask.resume()
        
    }

}
