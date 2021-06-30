//
//  CreateProfileViewController.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 6/25/21.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {
    
    @IBOutlet var usernameTextField: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confimTapped(_ sender: Any) {
        
        // Check if a user is logged in
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        // Get username  and check against whitespaces
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if username == nil || username == "" {
            return
        }
        
        // create profile
        UserService.createProfile(userId: Auth.auth().currentUser!.uid, username: username!) { (user) in
            
            if user != nil {
                let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
                
            } else {
                
            }
            
        }
        
    }
    

}
