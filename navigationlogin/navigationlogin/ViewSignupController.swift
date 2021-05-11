//
//  ViewSignupController.swift
//  navigationlogin
//
//  Created by René Zelada on 5/4/21.
//
import UIKit
import Firebase
import FirebaseAuth

class ViewSignupController: UIViewController {

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func Signup(_ sender: Any) {
        
        let password = validpassword(mypassword: self.Password.text!) //get text Field data & checked through the function


                if(password == false)
                {
                    // create the alert
                           let alert = UIAlertController(title: "Password", message: "Your password needs to have uppercases, at least 1 number and 1 special character", preferredStyle: UIAlertController.Style.alert)

                           // add an action (button)
                           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                           // show the alert
                           self.present(alert, animated: true, completion: nil) //Use to Alert Msg Box
                }
                else
                {
                     print("Login Safe")     //Use to Alert Msg Box
                
        //let email = "example3@gmail.com"
        //let password = "testtest"
        if  let email = self.Email.text, let password = self.Password.text{
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
           
            case .emailAlreadyInUse:
                let alert = UIAlertController(title: "Email", message: "The email address is already in use by another account", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
             
            case .invalidEmail:
                let alert = UIAlertController(title: "Email", message: "The email address is badly formatted", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            
            case .weakPassword:
                let alert = UIAlertController(title: "Password", message: "The password should have at least 8 characters", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            default:
                print("Error: \(error.localizedDescription)")
            }
          } else {
            print("User signs up successfully")
            let newUserInfo = Auth.auth().currentUser
         //   let email = newUserInfo?.email
        
            var ref: DatabaseReference!
            if  var user_phone = self.Email.text{
                user_phone = user_phone.replacingOccurrences(of: ".", with: "_", options: .literal, range: nil)
                ref = Database.database().reference().child(user_phone)
            ref.child("email").setValue(self.Email.text)
            ref.child("Name").setValue(self.Name.text)
            ref.child("Phone").setValue(self.Phone.text)
                let alert = UIAlertController(title: "Welcome", message: "Now you can login in to the app", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
            
            }
            
          }
        }
        }}
    }
    
    func validpassword(mypassword : String) -> Bool
        {
            let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
            let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
            return passwordtesting.evaluate(with: mypassword)
        }
}

