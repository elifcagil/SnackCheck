//
//  FavoritesViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var viewModel = FavoritesViewModel()
    
    @IBOutlet var favorilertableview: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Reload()
        viewModel.FetchFavorites()
        favorilertableview.delegate = self
        favorilertableview.dataSource = self
        
    }
    func Reload(){
        viewModel.onItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.favorilertableview.reloadData()
            }
        }
    }
}

extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorilerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fav = viewModel.favorilerList[indexPath.row]
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

