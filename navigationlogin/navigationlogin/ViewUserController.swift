//
//  ViewUserController.swift
//  navigationlogin
//
//  Created by René Zelada on 5/11/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewUserController: UIViewController {
    @IBOutlet weak var Name: UILabel?
    @IBOutlet weak var Email: UILabel?
    @IBOutlet weak var Phone: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userInfo = Auth.auth().currentUser
        let email = userInfo?.email
        var ref: DatabaseReference!

        if  var user_email = email{
            user_email = user_email.replacingOccurrences(of: ".", with: "_", options: .literal, range: nil)
            ref = Database.database().reference()
            ref.child(user_email).observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
              let value = snapshot.value as? NSDictionary
              let username = value?["Name"] as? String ?? ""
              let phonenumber = value?["Phone"] as? String ?? ""
              let useremail = value?["email"] as? String ?? ""
                
                self.Name?.text = "Name: " + username
                self.Email?.text = "Email: " + useremail
                self.Phone?.text = "Phone: " + phonenumber
            
              }) { (error) in
                print(error.localizedDescription)
            }
        
       
        }
        
        // Do any additional setup after loading the view.
    }

    }
    
