//
//  ViewController.swift
//  udemy_sqlpuan
//
//  Created by Eren Demir on 10.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var notTableView: UITableView!
    var notlarListesi = [Notlar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notTableView.delegate = self
        notTableView.dataSource = self
        veritabaniKopyala()

    }
    override func viewWillAppear(_ animated: Bool) {
        notlarListesi = Notlardao().tumNotlariAl()
        
        var toplam = 0
        for n in notlarListesi {
            toplam = toplam + (n.not1! + n.not2!)/2
        }
        
        if notlarListesi.count != 0 {
            navigationItem.prompt = "Ortalama: \(toplam/notlarListesi.count)"
        }else {
            navigationItem.prompt = "Ortalama: YOK"
        }
        
        notTableView.reloadData()
    }
    
    func veritabaniKopyala() {
        let bundleYol = Bundle.main.path(forResource: "notlar", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let kopyalanacakYol = URL(fileURLWithPath: hedefYol).appendingPathComponent("notlar.sqlite")
        if fileManager.fileExists(atPath: kopyalanacakYol.path){
            print("Veritabanı zaten var.")
        }else{
            do {
                try fileManager.copyItem(at: URL(fileURLWithPath: bundleYol!), to: URL(fileURLWithPath: kopyalanacakYol.path))
            }catch{
                print(error)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            print("toDetay")
            if let index = sender as? Int{
                let gidilecekVC = segue.destination as! NotDetayViewController
                gidilecekVC.gelenNot = notlarListesi[index]
            }
        }
    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notlarListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let not = notlarListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "notHucre", for: indexPath) as! NotHucreTableViewCell
        cell.dersLabel.text = not.ders_adi
        cell.vizeLabel.text = "\(not.not1!)"
        cell.finalLabel.text = "\(not.not2!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
}
