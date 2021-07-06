//
//  CameraViewController.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 6/26/21.
//

import UIKit

class CameraViewController: UIViewController {
    
    @IBOutlet var progressLabel: UILabel!
    
    @IBOutlet var progressBar: UIProgressView!
    
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Hide and reset all elements
        progressBar.alpha = 0
        progressBar.progress = 0
        
        doneButton.alpha = 0
        progressLabel.alpha = 0
        
        
    }
    
    func savePhoto(image: UIImage) {
        
        // Photo Service stores the photo
        PhotoService.savePhoto(image: image) { (pct) in
            
        }
    }

}
