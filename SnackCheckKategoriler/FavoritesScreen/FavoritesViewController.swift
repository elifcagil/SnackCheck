//
//  FavoritesViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    
    @IBOutlet var favorilertableview: UITableView!
    
    var favorilerList = [Urunler]()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let u1 = Urunler(urun_id: 1, urun_name: "Yüksek Protein Bar", urun_brand: "ZUBER", urun_resim: "proteinbar", kategori: category())
        
        favorilerList.append(u1)
        
        favorilertableview.delegate = self
        favorilertableview.dataSource = self
        
       
        
    }
    
    
}


extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorilerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fav = favorilerList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorilerhucre", for: indexPath) as! FavoritesTableViewCell
        cell.urunBrand.text = fav.urun_brand
        cell.urunName.text = fav.urun_name
        cell.urunimage.image = UIImage(named: fav.urun_resim!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print("Favorilerden \(favorilerList[indexPath.row].urun_name!) seçildi")
    }
}

