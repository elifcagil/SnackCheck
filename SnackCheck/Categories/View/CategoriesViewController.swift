//
//  CategoriessViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 21.04.2025.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoriestableview: UITableView!
    
       
    var viewModel:CategoryViewModel!
    let firestoreManager = FirestoreManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
           
            viewModel = CategoryViewModel(firestoreManager: firestoreManager)
            
            categoriestableview.delegate = self
            categoriestableview.dataSource = self
            Reload()
            viewModel.AllCategories()
        
        }
        
        func Reload(){
            viewModel.onFetched = { [weak self] category in
                DispatchQueue.main.async {
                    self?.categoriestableview.reloadData()
                }
            }
        }
    }


    extension CategoriesViewController : UITableViewDelegate ,UITableViewDataSource{
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.categoriesList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let category = viewModel.categoriesList[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell",for: indexPath) as! CategoriesTableViewCell
            cell.categoryNameLabel.text = category.category_name
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.performSegue(withIdentifier: "categoryToProduct", sender: indexPath.row)
            
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let index = sender as? Int
            let togoVC = segue.destination as! ProductViewController
            
            let ViewModel = ProductViewModel(fireStoreManager: firestoreManager)
            ViewModel.category = viewModel.categoriesList[index!]
            togoVC.viewModel = ViewModel
        }
    }



