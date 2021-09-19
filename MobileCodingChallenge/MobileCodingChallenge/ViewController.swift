//
//  ViewController.swift
//  MobileCodingChallenge
//
//  Created by René Zelada on 7/14/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var Table: UITableView!
        var lista = [List]()
    let optionalURL : String = "https://firebasestorage.googleapis.com/v0/b/quinek-8206e.appspot.com/o/open-book.png?alt=media&token=6449122b-6cfb-43c0-8aa2-ba574990282a"
        
        override func viewDidLoad() {
            super.viewDidLoad()
           
            Table.delegate = self
            Table.dataSource = self
            addJson()
        }
    
    func addJson(){
        let url = URL(string: "http://de-coding-test.s3.amazonaws.com/books.json")
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in

                if error != nil {
                    print("DataTask error", error!)

                } else {
                    do {
                        if let bookData = try JSONSerialization.jsonObject(with: data!) as? [[String:String]] {
                            for book in bookData {
                                let title = book["title"]!
                                let author = book["author"] ?? ""
                                let imgURL = book["imageURL"] ?? ""
                              //  print(title,author,imgURL)
                                let lista1 = List(Title: title, Author: author, Image: imgURL)
                                print(lista1)
                                self.lista.append(lista1)
                                DispatchQueue.main.async {
                                    self.Table.reloadData()
                                            }
                            }
                           
                        }
                    }
                    catch {
                        print("Serialization error", error)
                    }
                }

            }
            task.resume()
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return lista.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = Table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let list = lista[indexPath.row]
            cell.textLabel?.text = list.Title
            cell.detailTextLabel?.text = list.Author
            cell.imageView?.image = UIImage(data: addImage(imageUrl: list.Image) as! Data)
            return cell
            }
            
    func addImage(imageUrl: String) -> Any
    {
        let url = NSURL(string:imageUrl)
        let urlBook = NSURL(string: optionalURL)
        let imagedata = NSData.init(contentsOf: (url)!  as URL)
        if(imagedata != nil){
            return imagedata as Any
        }
        else{
            let imagedata = NSData.init(contentsOf: (urlBook)!  as URL)
            return imagedata as Any
        }
        
    }
       

}
    
    

