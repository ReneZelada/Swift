//
//  ViewController.swift
//  bookApp
//
//  Created by René Zelada on 8/31/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var lista = [List]()
    let optionalURL : String = "https://firebasestorage.googleapis.com/v0/b/quinek-8206e.appspot.com/o/open-book.png?alt=media&token=6449122b-6cfb-43c0-8aa2-ba574990282a"

    @IBOutlet weak var Table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Table.delegate = self
        Table.dataSource = self
        addJson()
    }
    // this funtion has been created to ge the data and append this data inside the struct, once the data has been saved it will reload the table to show the data inside the UItable
    func addJson()
    {
        let url = URL(string: "http://de-coding-test.s3.amazonaws.com/books.json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in

            if error != nil {
                print(error!)

            } else {
                do {
                    if let bookData = try JSONSerialization.jsonObject(with: data!) as? [[String:String]] {
                        for book in bookData {
                            
                            let books = List(Title: book["title"]!, Author: book["author"] ?? "", Image: book["imageURL"] ?? "")
                    
                            self.lista.append(books)
                            DispatchQueue.main.async {
                                self.Table.reloadData()
                                        }
                        }
                       
                    }
                }
                catch {
                    print(error)
                }
            }

        }
        task.resume()
    }
    //this other funtion has been created due to when we download the json data it comes on URL and we need to get the image it self from the url it has an optional url to show a random image if the json doesn't come with a url from the image!
    func addImage (imageUrl: String) -> Any{
        let url = NSURL(string: imageUrl)
        let urlOptionalBook = NSURL(string: optionalURL)
        let imagedata = NSData.init(contentsOf: (url)! as URL)
        
        if(imagedata != nil){
            return imagedata as Any
        }
        else
        {
            let imagedata = NSData.init(contentsOf: (urlOptionalBook)! as URL)
            return imagedata as Any
        }
    }
    //this are basic function that are added once you are working with a UItable view since we are getting the data from a json we need to count the struct to get the number of rows that we are going to show
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    //this funtion add the information to the labels from the cell that has been added on the table to get the image we use the addImage funtion
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let list = lista[indexPath.row]
        cell.textLabel?.text = list.Title
        cell.detailTextLabel?.text = list.Author
        cell.imageView?.image = UIImage(data: addImage(imageUrl: list.Image) as! Data)
        return cell
    }


}

