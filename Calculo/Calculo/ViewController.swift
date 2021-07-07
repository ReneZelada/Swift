//
//  ViewController.swift
//  Calculo
//
//  Created by René Zelada on 7/6/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var descuento: UILabel!
    @IBOutlet weak var cantidadTxt: UITextField!
    
    @IBOutlet weak var porcentageTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoDown), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    @objc func tecladoUp(){
        let sizeScreen = UIScreen.main.nativeBounds.height
        if sizeScreen == 1136{
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y = -50
        }
        }
    }
    @objc func tecladoDown(){
        let sizeScreen = UIScreen.main.nativeBounds.height
        if sizeScreen == 1136{
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
        }
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func calcular(_ sender: UIButton) {
        guard let cantidad = cantidadTxt.text else {return}
        guard let porcentaje = porcentageTxt.text else {return}
        let cant = (cantidad as NSString).floatValue
        let porciento = (porcentaje as NSString).floatValue
        
        let desc = cant * porciento/100
        let res = cant - desc
        
        resultado.text = "$\(res)"
        descuento.text = "$\(desc)"
        self.view.endEditing(true)
    }
    @IBAction func limpiar(_ sender: UIButton) {
        
        cantidadTxt.text = ""
        porcentageTxt.text = ""
        resultado.text = "$0.00"
        descuento.text = "$0.00"
        
    }
}

