//
//  SecondController.swift
//  NavigationController
//
//  Created by René Zelada on 7/7/21.
//

import UIKit

class SecondController: UIViewController {

    @IBOutlet weak var Text: UILabel!
    var saludo : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        Text.text = saludo
    }

    @IBAction func Regresar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
