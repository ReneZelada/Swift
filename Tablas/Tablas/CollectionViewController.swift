//
//  CollectionViewController.swift
//  Tablas
//
//  Created by René Zelada on 7/7/21.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var coleccion: UICollectionView!
    
    var lista = [Lista]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coleccion.delegate = self
        coleccion.dataSource = self
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lista.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = coleccion.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellCollectionCollectionViewCell
        let list = lista[indexPath.row]
        cell.Nombre.text = list.nombre
        cell.Imagen.image = UIImage(systemName: "person.crop.circle.fill")
        return cell
    }

}
