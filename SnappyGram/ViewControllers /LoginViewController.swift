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
        <#code#>
    }
    
}
