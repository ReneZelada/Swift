//
//  LoginController.swift
//  navigationlogin
//
//  Created by René Zelada on 5/4/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewLoginController: UIViewController {

   
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Login(_ sender: Any) {
        let email = "example@gmail.com"
        let password = "fooPassword"

        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed: break
              // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
            
            case .userDisabled: break
              // Error: The user account has been disabled by an administrator.
            case .wrongPassword: break
              // Error: The password is invalid or the user does not have a password.
            case .invalidEmail: break
              // Error: Indicates the email address is malformed.
            default:
                print("Error: \(error.localizedDescription)")
            }
          } else {
            print("User signs in successfully")
            let userInfo = Auth.auth().currentUser
            _ = userInfo?.email
          }
        }
        
    }
    
    
}
