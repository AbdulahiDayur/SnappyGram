//
//  SettingsViewController.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 6/25/21.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutTapped(_ sender: Any) {
        
        do {
            
            // sign out user and clear storage
            try Auth.auth().signOut()
            LocalStorageService.clearUser()
        
            // Transition back to authentication flow
            let loginNavVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginNavController)
            
            self.view.window?.rootViewController = loginNavVC
            self.view.window?.makeKeyAndVisible()
            
        } catch {
            
        }
    }
    

}
