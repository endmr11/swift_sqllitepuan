//
//  NotDetayViewController.swift
//  udemy_sqlpuan
//
//  Created by Eren Demir on 10.05.2022.
//

import UIKit

class NotDetayViewController: UIViewController {
    
    @IBOutlet weak var dersTextfield: UITextField!
    @IBOutlet weak var vizeTextfield: UITextField!
    @IBOutlet weak var finalTextfield: UITextField!
    
    var gelenNot:Notlar?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let n = gelenNot {
            dersTextfield.text = n.ders_adi
            vizeTextfield.text = "\(n.not1!)"
            finalTextfield.text = "\(n.not2!)"
        }
        
    }
    
    @IBAction func btnDuzenle(_ sender: Any) {
        
        if let id = gelenNot?.not_id, let d = dersTextfield.text, let v = vizeTextfield.text, let f = finalTextfield.text {
            if let n1 = Int(v), let n2 = Int(f) {
                Notlardao().notDuzenle(not_id: id, ders_adi: d, not1: n1, not2: n2)
                navigationController?.popViewController(animated: true)
            }
        }
        
    }
    @IBAction func btnSil(_ sender: Any) {
        if let id = gelenNot?.not_id {
            Notlardao().notSil(not_id: id)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
