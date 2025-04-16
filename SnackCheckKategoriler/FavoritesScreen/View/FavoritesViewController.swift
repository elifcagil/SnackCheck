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
        let secilenUrun = viewModel.favorilerList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detayVC = storyboard.instantiateViewController(withIdentifier: "DetayViewController") as? UrunDetayViewController {
            detayVC.urun = secilenUrun
            if let sheet = detayVC.sheetPresentationController {
                   sheet.detents = [ .large()] // İstersen sadece .large() yap
                   sheet.prefersGrabberVisible = true // Üstte küçük tutamaç çizgisi çıkar
                  // sheet.prefersScrollingExpandsWhenScrolledToEdge = true //tutamaç çizgisini kaydırarak ekranın büyümesini sağlar.
                   sheet.preferredCornerRadius = 24 // Köşeleri oval yapar
               }
                present(detayVC, animated: true, completion: nil)
            
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
           
            (action,view,completionHandler) in
            let item = self.viewModel.favorilerList[indexPath.row]
            self.viewModel.deleteFavorite(item:item)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    
    
    
}

