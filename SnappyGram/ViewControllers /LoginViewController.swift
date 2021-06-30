//
//  LoginViewController.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 6/25/21.
//

import UIKit
import FirebaseEmailAuthUI


class LoginViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Create Firebase AuthUI obj
        let authUI = FUIAuth.defaultAuthUI()
        
        if let authUI = authUI {
            authUI.delegate = self
            
            // Set sign in providers
            authUI.providers = [FUIEmailAuth()]
            
            // Get the prebuilt ui vc
            let authViewController = authUI.authViewController()
            
            present(authViewController, animated: true, completion: nil)
        }
    }
}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        if error != nil {
            return
        }
        
        let user = authDataResult?.user
        // Check on the database side if user has a profile
        
        if let user = user {
            
            UserService.retrieveProfile(userId: user.uid) { (user) in
                
                // If not, go to create profile view controller
                if user == nil {
                    self.performSegue(withIdentifier: Constants.Storyboard.profileSegue, sender: self)
                    
                } else {
                    
                    // Save the user to local storage
                    LocalStorageService.saveUser(userId: user!.userId, username: user!.userName)
                    
                    // If so, go to tab bar controller; create an instance
                    let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                    
                    guard tabBarVC != nil else {
                        return
                    }
                    
                    // Set it as the root view controller of the window
                    self.view.window?.rootViewController = tabBarVC
                    self.view.window?.makeKeyAndVisible()
                    
                }
            }

        }
    }
    
}
