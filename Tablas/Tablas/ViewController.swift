//
//  ViewController.swift
//  Tablas
//
//  Created by René Zelada on 7/7/21.
//

import UIKit

struct Lista {
    let nombre : String
    let email : String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabla: UITableView!
    var lista = [Lista]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabla.delegate = self
        tabla.dataSource = self
        
        let lista1 = Lista(nombre: "Jorge", email: "jorge@gmail.com")
        let lista2 = Lista(nombre: "Juan", email: "jorge@gmail.com")
        let lista3 = Lista(nombre: "Pedro", email: "jorge@gmail.com")
        let lista4 = Lista(nombre: "Santiago", email: "jorge@gmail.com")
        let lista5 = Lista(nombre: "Jose", email: "jose@gmail.com")

        lista.append(lista1)
        lista.append(lista2)
        lista.append(lista3)
        lista.append(lista4)
        lista.append(lista5)
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let list = lista[indexPath.row]
        cell.textLabel?.text = list.nombre
        cell.detailTextLabel?.text = list.email
        cell.imageView?.image = UIImage(systemName: "person.crop.circle.fill")
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            if let id = tabla.indexPathForSelectedRow{
                let fila = lista[id.row]
                let destino = segue.destination as? DetalleViewController
                destino?.datosLista = fila
                
            }
        }
    }
}

