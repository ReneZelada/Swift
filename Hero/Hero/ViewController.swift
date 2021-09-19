//
//  ViewController.swift
//  Hero
//
//  Created by René Zelada on 8/31/21.
//

import UIKit

class ViewController: UIViewController  {
   
    @IBOutlet weak var Table: UITableView!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
      //  Table.delegate = self
       // Table.dataSource = self
        loadJSON()
    
    }
    
/*    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return nil
    }*/
    
    func loadJSON() {
        let url = URL(string: "https://superheroapi.com/api/10222983375945201/search/bat")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in

            if error != nil {
                print(error!)

            } else {
                do {
                    if let heroData = try JSONSerialization.jsonObject(with: data!) as? [[String:String]] {
                        for hero in heroData {
                            print(hero)
                           // let books = List(Title: book["title"]!, Author: book["author"] ?? "", Image: book["imageURL"] ?? "")
                    
                           // self.lista.append(books)
                         //   DispatchQueue.main.async {
                           //     self.Table.reloadData()
                           //             }
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
}

