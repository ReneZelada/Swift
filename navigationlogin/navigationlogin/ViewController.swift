//
//  ViewController.swift
//  navigationlogin
//
//  Created by René Zelada on 5/4/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var Login: UIView!
    @IBOutlet weak var Signup: UIView!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LoginFirebase(_ sender: Any) {
        //let email = "example@gmail.com"
       // let password = "testtest"
        if  let email = self.Email.text, let password = self.Password.text{
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
             
                case .wrongPassword:
                    let alert = UIAlertController(title: "Wrong Password", message: "Please check your password", preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                  // Error: The password is invalid or the user does not have a password.
             
                 case .invalidEmail:
                    let alert = UIAlertController(title: "Wrong Email", message: "Please check your email", preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    
                default:
                    print("Error: \(error.localizedDescription)")
                }
              } else {
                print("User signs in successfully")
              //  let userInfo = Auth.auth().currentUser
              //  let email = userInfo?.email
               // self.performSegue(withIdentifier: "UserView", sender: self)
                let storyboard = UIStoryboard(name: "Main", bundle: nil);
                let vc = storyboard.instantiateViewController(withIdentifier: "UserView") ; // MySecondSecreen the storyboard ID
                self.present(vc, animated: true, completion: nil);
              }
                
            }
        }
      
    }
    @IBAction func Show(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex == 0){
            UIView.animate(withDuration: 0.5, animations: {
                self.Login.alpha = 0.0
                self.Signup.alpha = 1.0
            })
            
        }
        else{
            UIView.animate(withDuration: 0.5, animations: {
                self.Login.alpha = 1.0
                self.Signup.alpha = 0.0
            })
        }
    }
   
    
}

