//
//  ViewController.swift
//  NewsJson
//
//  Created by René Zelada on 7/12/21.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    @IBOutlet weak var tabla: UITableView!
  
    var lista = [Lista]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tabla.delegate = self
        tabla.dataSource = self
    
            
        
       
        let url = URL(string: "https://de-coding-test.s3.amazonaws.com/books.json")
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
                                let lista1 = Lista(Title: title, Author: author, Image: imgURL)
                                print(lista1)
                                self.lista.append(lista1)
                                DispatchQueue.main.async {
                                    self.tabla.reloadData()
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
        let cell = tabla.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let list = lista[indexPath.row]
        cell.textLabel?.text = list.Title
        cell.detailTextLabel?.text = list.Author
        
        if let url = URL(string: list.Image){
            if let data = try? Data(contentsOf: url){
                cell.imageView?.image = UIImage(data: data)
            }
        }
     //   cell.imageView?.image = UIImage(systemName: "person.crop.circle.fill")
        return cell
        
    }
}

