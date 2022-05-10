//
//  NotEkleViewController.swift
//  udemy_sqlpuan
//
//  Created by Eren Demir on 10.05.2022.
//

import UIKit

class NotEkleViewController: UIViewController {
    
    @IBOutlet weak var dersTextfield: UITextField!
    @IBOutlet weak var vizeTextfield: UITextField!
    @IBOutlet weak var finalTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func btnEkle(_ sender: Any) {
        if let d = dersTextfield.text, let v = vizeTextfield.text, let f = finalTextfield.text {
            if let n1 = Int(v), let n2 = Int(f) {
                Notlardao().notEkle(ders_adi: d, not1: n1, not2: n2)
                navigationController?.popViewController(animated: true)
            }
        }
    }
}
