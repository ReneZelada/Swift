//
//  ViewController.swift
//  dropDown
//
//  Created by René Zelada on 8/5/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var textBox2: UITextField!
    @IBOutlet weak var dropDown2: UIPickerView!
    
    var list = ["1","2","3"]
    var list2 = ["3","2","1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dropDown.delegate = self
                self.dropDown.dataSource = self
        self.dropDown2.delegate = self
                self.dropDown2.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return list.count
            
        }else{
            return list2.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
           self.view.endEditing(true)
           return list[row]
        }else{
            self.view.endEditing(true)
            return list2[row]
        }
       }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.textBox.text = self.list[row]
            self.dropDown.isHidden = true
            
        }else{
            self.textBox2.text = self.list2[row]
            self.dropDown2.isHidden = true
        }
        }

       
    @IBAction func edit(_ sender: UITextField) {
        textBox.resignFirstResponder()
        self.dropDown.isHidden = false
        
    }
    @IBAction func edit2(_ sender: UITextField) {
        textBox2.resignFirstResponder()
        self.dropDown2.isHidden = false
    }
    
}

