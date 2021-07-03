//
//  MainTabBarController.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 7/1/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        // Detect which tab was tapped on
        if item.tag == 2 {
            
            // Camera tab was tapped on
            
            // Create the action sheet
            let actionSheet = UIAlertController(title: "Add a Photo", message: "Select a source", preferredStyle: .actionSheet)
            
            // only add camera button it's available
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                // Create and add the Camera button
                let cameraButton = UIAlertAction(title: "Camera", style: .default) { (action) in
                    
                    // Display the UiimagePickerController set to camera mode
                }
                actionSheet.addAction(cameraButton)
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                // Create and the Photo Library button
                let libraryButton = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                    
                    // Display the UIimagePickercontroller set to library mode
                }
                actionSheet.addAction(libraryButton)
            }
            
            // Create and add the Cancel button
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelButton)
            
            // Display the action sheet
            present(actionSheet, animated: true, completion: nil)
        }
    }


}
