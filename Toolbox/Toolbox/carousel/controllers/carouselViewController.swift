//
//  carouselViewController.swift
//  Toolbox
//
//  Created by René Zelada on 11/9/21.
//

import UIKit
import AVFoundation
import AVKit

class carouselViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionViewcc: UICollectionView!
    @IBOutlet var firstHeight: NSLayoutConstraint!
    @IBOutlet var colletcionViewcc2: UICollectionView!
    @IBOutlet var titleOne: UILabel!
    @IBOutlet var titleTwo: UILabel!
    
    var lista = [Lista]()
    var list = [Lista2]()

    var imageT = ""
    var imageT2 = ""
    
    var c = 0
    var timer = Timer()
    
    let token = UserDefaults.standard.string(forKey: "token")
    let type = UserDefaults.standard.string(forKey: "type")
    let myUrl = URL(string: "https://echo-serv.tbxnet.com/v1/mobile/data")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFirstArray(number: 0)
        loadSecondArray(number: 1)
        collectionViewcc.delegate = self
        collectionViewcc.dataSource = self
        colletcionViewcc2.delegate = self
        colletcionViewcc2.dataSource = self
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerStart() {
           c += 1
        if c >= 300{
            print("--------timer---------")
            c = 0
            timer.invalidate()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tab:ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController

            tab.modalPresentationStyle = .overCurrentContext
            tab.modalTransitionStyle = .crossDissolve
            self.present(tab, animated: true, completion: nil)
        }
       }
    
    func loadFirstArray(number: Int){
            
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            request.addValue("application/json", forHTTPHeaderField:"accept")
            request.addValue("\(type!) " + token!, forHTTPHeaderField: "authorization")
            

            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil
                {
                    
                    self.Alert(message: "Lo sentimos, algo salio mal!")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                   
                    if let parseJSON = json {
                        
                       
                        print((parseJSON[number] as AnyObject) ["type"] as! String)
                        
                        self.imageT = ((parseJSON[number] as AnyObject) ["type"] as! String)
                             
                              if let data = (parseJSON[number] as AnyObject)["items"] as? [[String: Any]] {
                                    for dato in data{
                                        let image = dato["imageUrl"] ?? ""
                                        let desc = dato["description"] ?? ""
                                        let title = dato["title"] ?? ""
                                        let video = dato["videoUrl"] ?? ""
                                        
                                        let lista1 = Lista(description: desc as! String, imageUrl: image as! String, title: title as! String , videoUrl: video as! String)
                                        print(lista1)
                                        self.lista.append(lista1)
                                        DispatchQueue.main.async {self.collectionViewcc.reloadData()
                                            self.titleOne.text = ((parseJSON[number] as AnyObject) ["title"] as! String)
                                        }
                             }
                            }
                           
                    } else {
                        self.Alert(message: "Lo sentimos, algo salio mal!")
                       
                    }
                    
                } catch {
                    self.Alert(message: "Lo sentimos, algo salio mal!")
                       
                        print(error)
                    }
                
            }
            task.resume()
        
      
    }
    func loadSecondArray(number: Int){
            
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "GET"
        
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            request.addValue("application/json", forHTTPHeaderField:"accept")
            request.addValue("\(type!) " + token!, forHTTPHeaderField: "authorization")
            

            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil
                {
                    
                    self.Alert(message: "Lo sentimos, algo salio mal!")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                   
                    if let parseJSON = json {
                        
                       
                                print(parseJSON)
                        self.imageT2 = ((parseJSON[number] as AnyObject) ["type"] as! String)
                              if let data = (parseJSON[number] as AnyObject)["items"] as? [[String: Any]] {
                                    for dato in data{
                                        let image = dato["imageUrl"] ?? ""
                                        let desc = dato["description"] ?? ""
                                        let title = dato["title"] ?? ""
                                        let video = dato["videoUrl"] ?? ""
                                        
                                        let lista2 = Lista2(description: desc as! String, imageUrl: image as! String, title: title as! String , videoUrl: video as! String)
                                        print(lista2)
                                        self.list.append(lista2)
                                        DispatchQueue.main.async { self.colletcionViewcc2.reloadData()
                                            self.titleTwo.text = ((parseJSON[number] as AnyObject) ["title"] as! String)
                                        }
                             }
                            }
                           
                    } else {
                        self.Alert(message: "Lo sentimos, algo salio mal!")
                    }
                    
                } catch {
                    self.Alert(message: "Lo sentimos, algo salio mal!")
                    
                    }
                
            }
            task.resume()
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colletcionViewcc2{
            return list.count
        }
        return lista.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colletcionViewcc2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCollectionViewCell", for: indexPath) as! secondCollectionViewCell
            cell.secondTitle.text = lista[indexPath.row].title
            if let url = URL(string: list[indexPath.row].imageUrl){
                       if let data = try? Data(contentsOf: url){
                           if imageT2 == "thumb"{
                               cell.secondImage.image = resize(image: UIImage(data: data)!, toSize: CGSize(width: 170.0, height: 120.0))
                           }else{
                               cell.secondImage.image = resize(image: UIImage(data: data)!, toSize: CGSize(width: 120.0, height: 200.0))
                           }
                       }
                   }
            
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCollectionViewCell", for: indexPath) as! firstCollectionViewCell
        cell.firstTitle.text = lista[indexPath.row].title
        if let url = URL(string: lista[indexPath.row].imageUrl){
                   if let data = try? Data(contentsOf: url){
                       if imageT == "thumb"{
                       cell.firstImage.image = resize(image: UIImage(data: data)!, toSize: CGSize(width: 170.0, height: 120.0))
                       }
                       else{cell.firstImage.image = resize(image: UIImage(data: data)!, toSize:  CGSize(width: 120.0, height: 200.0))}
                   }
               }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colletcionViewcc2{
         
            let urlVideo = URL(string: list[indexPath.item].videoUrl)
            if let urlVideo = urlVideo {
                let player = AVPlayer(url:urlVideo)
                let vc = AVPlayerViewController()
                vc.player = player
                present(vc, animated: true)
            }else{
                self.Alert(message: "video no disponible!")
            }
            
        }else{
            let urlVideo = URL(string: lista[indexPath.item].videoUrl)
            if let urlVideo = urlVideo {
                let player = AVPlayer(url:urlVideo)
                let vc = AVPlayerViewController()
                vc.player = player
                present(vc, animated: true)
            }else{
                self.Alert(message: "Lo sentimos, algo salio mal!")
            }
        }
    }
    
    func resize(image: UIImage, toSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size,false,1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let resizedImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return resizedImage
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    func Alert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Accept", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


