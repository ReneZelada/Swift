//
//  ViewController.swift
//  chucknorris
//
//  Created by René Zelada on 2/12/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var list = [List]()
    var cont = 0

    @IBOutlet weak var Table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Table.delegate = self
        Table.dataSource = self
        while(cont <= 15){
            getJson()
            cont += 1
        }
    }//dispatch grow peticiones asyn no sync
    
    func getJson(){
        let url = URL(string: "https://api.chucknorris.io/jokes/random")
               let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in

                   if error != nil {
                       print(error!)

                   } else {
                       do {
                           if let jsonData = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                               print(jsonData["icon_url"]!)
                               print(jsonData["value"]!)
                              let chuck = List(Icon: jsonData["icon_url"] as! String, Value: jsonData["value"] as! String)
                               self.list.append(chuck)
                            DispatchQueue.main.async {
                            self.Table.reloadData()}
                        
                           }
                       }
                       catch {
                           print(error)
                       }
                   }
               }
               task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
               let list = list[indexPath.row]
               cell.textLabel?.text = list.Value
               cell.imageView?.image = UIImage(data: addImage(imageUrl: list.Icon) as! Data)
               return cell
    }
    
    func addImage (imageUrl: String) -> Any{
            let url = NSURL(string: imageUrl)
            let imagedata = NSData.init(contentsOf: (url)! as URL)
            
            return imagedata as Any // swift package manager, cartage 
        }
    
}

