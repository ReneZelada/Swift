//
//  ViewController.swift
//  NavigationController
//
//  Created by René Zelada on 7/7/21.
//

import UIKit

class ViewController: UIViewController {
        let hola = "Hola como estas"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Enviar"{
            let destino = segue.destination as? SecondController
            destino?.saludo = hola
        }
    }

}

