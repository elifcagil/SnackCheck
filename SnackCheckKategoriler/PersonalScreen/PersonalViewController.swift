//
//  PersonalViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class PersonalViewController: UIViewController {
    
    
    @IBOutlet var userimage: UIImageView!
    
    @IBOutlet var settingtableview: UITableView!
    
    @IBOutlet var userdescLabel: UILabel!
    
    var personelItem = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        personelItem = ["Hesap Ayarları","Kişi Bilgileri","Bildirimler","Sağlık Verileri","Oturumu Kapat"]
        
        
        
        settingtableview.delegate = self
        settingtableview.dataSource = self
        
    }
    

}
extension PersonalViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personelItem.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hucre = personelItem[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "personelhucre", for: indexPath) as! PersonalTableViewCell
        cell.itemNameLabel.text = hucre
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) seçildi")
    }
    
    
    
}
