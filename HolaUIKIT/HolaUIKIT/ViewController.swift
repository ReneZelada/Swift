//
//  ViewController.swift
//  HolaUIKIT
//
//  Created by René Zelada on 6/9/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Boton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Titulo", message: "Msj de la alerta", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            print("Aceptar")
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}

