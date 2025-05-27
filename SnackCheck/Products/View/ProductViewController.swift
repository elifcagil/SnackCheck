//
//  UrunlerViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import UIKit

class ProductViewController: UIViewController {
    
   //MARK: -Properties
    
    var viewModel:ProductViewModel!
   
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var productsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateMethods()
        title = viewModel.category?.category_name
        SetUpUI()
        viewModel.productToCategory()
       
        }
    
    //MARK: -HelperMethods
    
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.onFetched = { [weak self]  in
            DispatchQueue.main.async {
                self?.productsCollectionView.reloadData()
            }
        }
        viewModel.onFavoriteChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.productsCollectionView.reloadData()
            }
        }
    }
    private func delegateMethods(){
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        searchbar.delegate = self
    }
    private func SetUpUI(){
        
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.productsCollectionView.frame.size.width //collectionciewın genişliğini aldık
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right:10) //sağdan soldan yukardan aşapıdan 10 ar birim boşluk bıraktık
        let cellWidth = (width-30)/2 //oluşmasını istediğimiz hücrenin genisliğini bir değişkende tuttuk 10 ar birim boşluk bıraktığımız için eran genişliğinden 30 çıkardık ve bir satırda 2 tane olmasını istediğimiz için 2 ye böldük
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.3)
        design.minimumInteritemSpacing = 10 //yatayda hücreler arası istediğimiz boşluk
        design.minimumLineSpacing = 10 //dikeyde hücreler arası boşluk
        
        productsCollectionView.collectionViewLayout = design //collectionview a hazırladığımız tasarımı ekledik.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let togoVC = segue.destination as! ProductButtonDetailViewController
        
        let ViewModel = ProductButtonDetailViewModel()
        ViewModel.product = viewModel.productList[index!]
        togoVC.viewModel = ViewModel
        
    }
}
// MARK: -CollectionViewDelegate

extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = viewModel.productList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productItem", for: indexPath) as! ProductCollectionViewCell
        
        cell.onTapFavorite = { [weak self] productId in
            self?.viewModel.favoriteProduct(with: productId)
            
        }
        
        cell.configure(product)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "productToDetail", sender: indexPath.row)
    }
    
}
// MARK: - UISearchBarDelegate
extension ProductViewController : UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchview:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader,withReuseIdentifier: "searchbar", for: indexPath)
        return searchview
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.isSearch = false
            //viewModel.ProductToCategory()
        }else{
            viewModel.isSearch = true
            viewModel.searchedProduct = (viewModel.productList.filter { $0.product_name?.lowercased().contains(searchText.lowercased()) ?? false})
            viewModel.productList = viewModel.searchedProduct
            
        }
        
        print("Arama sonucu:\(searchText)")
    }
}
