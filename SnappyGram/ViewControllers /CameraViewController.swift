//
//  CameraViewController.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 6/26/21.
//

import UIKit

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func savePhoto(image: UIImage) {
        
        // Photo Service stores the photo
        PhotoService.savePhoto(image: image)
    }

}
