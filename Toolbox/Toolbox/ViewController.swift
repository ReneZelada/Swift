//
//  ViewController.swift
//  Toolbox
//
//  Created by René Zelada on 11/8/21.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

    @IBAction func signin(_ sender: UIButton) {
   
        let myUrl = URL(string: "https://echo-serv.tbxnet.com/v1/mobile/auth")
        var request = URLRequest(url:myUrl!)
       
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["sub" : "ToolboxMobileTest"] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
           
            return
        }
        
         let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    if parseJSON["sub"] == nil
                    {
                        self.Alert(message: "Lo sentimos, algo salio mal!")
                        return
                    }
                   
                    let Token = parseJSON["token"] as? String
                    let Type = parseJSON["type"] as? String
                    print("Access token: \(String(describing: Token!))")
                    print(Type!)
                
                    
                    UserDefaults.standard.set(Token!, forKey: "token")
                    UserDefaults.standard.set(Type!, forKey: "type")
                    
                    if Token != nil{
                        self.openStoryboard()
                    }
                    
                
                }} catch {
                    self.Alert(message: "Lo sentimos, algo salio mal!")
            }
    
         }
        task.resume()
        
    }
    func openStoryboard(){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "CarouselStoryboard", bundle: nil)
            let tab:carouselViewController = storyboard.instantiateViewController(withIdentifier: "carouselViewController") as! carouselViewController

            tab.modalPresentationStyle = .overCurrentContext
            tab.modalTransitionStyle = .crossDissolve
            self.present(tab, animated: true, completion: nil)
        }
    }
    func Alert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Accept", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

