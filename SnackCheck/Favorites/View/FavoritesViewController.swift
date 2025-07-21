//
//  FavoritesViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: -Properties
    
    var viewModel:FavoritesViewModel!
    var firestoreManager = FirestoreManager()
    var userManager = UserManager()
    
    @IBOutlet var favoritestableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoritesViewModel(firestoreManager: firestoreManager,userManager: userManager)
        
        favoritestableview.delegate = self
        favoritestableview.dataSource = self
        Reload()

        
        
    }
    //MARK: -HelperMethods
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.FetchFavorites()
    }
    func Reload(){
        viewModel.onFetched = { [weak self] favorites in
            DispatchQueue.main.async {
                self?.favoritestableview.reloadData()
            }
        }
    }
}
// MARK: - TableViewDelegate
extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fav = viewModel.favoritesList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! FavoritesTableViewCell
        cell.productBrand.text = fav.product_brand
        cell.productName.text = fav.product_name
        cell.productImage.image = UIImage(named: fav.product_image!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = viewModel.favoritesList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? ProductButtonDetailViewController {
            let viewModel = ProductButtonDetailViewModel()
            viewModel.product = selectedProduct
            detailVC.viewModel = viewModel
            
            if let sheet = detailVC.sheetPresentationController {
                   sheet.detents = [ .large()] // İstersen sadece .large() yap
                   sheet.prefersGrabberVisible = true // Üstte küçük tutamaç çizgisi çıkar
                  // sheet.prefersScrollingExpandsWhenScrolledToEdge = true //tutamaç çizgisini kaydırarak ekranın büyümesini sağlar.
                   sheet.preferredCornerRadius = 24 // Köşeleri oval yapar
               }
                present(detailVC, animated: true, completion: nil)
            
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
           
            (action,view,completionHandler) in
            let item = self.viewModel.favoritesList[indexPath.row]
            self.viewModel.deleteFavorite(item:item)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

