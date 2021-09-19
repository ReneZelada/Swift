//
//  ViewController.swift
//  Weather
//
//  Created by René Zelada on 7/9/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var background: UIView!
    @IBOutlet weak var temperatura: UILabel!
    @IBOutlet weak var Clima: UILabel!
    @IBOutlet weak var ciudad: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let url = URL(string: "https://superheroapi.com/api/10222983375945201/search/bat"){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in

                        guard let data = data else {
                            print("Data != Data")
                            return

                        }
                        do {
                             if let myJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                                //For getting customer_id try like this
                                if let data = myJSON["results"] as? [[String: Any]] {
                                   
                                        let weather = data.first?["name"] as? String
                                        print(weather!)
                                                                        
                                }
                             /*   if let main = myJSON["title"] as? Dictionary<String, AnyObject> {

                                    if let currentTemperature = main["title"] as? Double {
                                        print(currentTemperature)
                                    }
                                }
                                if let main2 = myJSON["sys"] as? Dictionary<String, AnyObject> {
                                    if let country = main2["country"] as? String {
                                        print(country)
                                    }
                                    
                                }*/
                            }
                            

                        } catch let jsonError {
                            print ("jsonError")
                            print (jsonError)
                        }

                    }.resume()
            }
            
        }

}







