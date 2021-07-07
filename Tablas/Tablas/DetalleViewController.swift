//
//  DetalleViewController.swift
//  Tablas
//
//  Created by René Zelada on 7/7/21.
//

import UIKit

class DetalleViewController: UIViewController {
    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var Email: UILabel!
    
    var datosLista : Lista?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Nombre.text = datosLista?.nombre
        Email.text = datosLista?.email

    }
}
