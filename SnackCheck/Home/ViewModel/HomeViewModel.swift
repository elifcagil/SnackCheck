//
//  AnaSayfaViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 14.04.2025.
//

import Foundation


class HomeViewModel{
    
  //MARK: -Properties
    
    var productList : [Product] = []
    var allProductList : [Product] = []
    var onFetched: (([Product]) -> Void)?
    var onFavoriteChanged: (() -> Void)?
    var isSearch = false
    var searchedProduct = [Product]()
    var searchedWord : String = ""
    
    var firestoreManager:FirestoreManager!
    var userManager:UserManager!
    
    init(firestoreManager:FirestoreManager,userManager:UserManager){
        self.firestoreManager = firestoreManager
        self.userManager = userManager
    }
    
    
    //MARK: -HelperMethods
    
   
    
    func FetchAllProduct(){
        firestoreManager.FetchProduct{ [weak self] products in
            self?.productList = products
            self?.allProductList = products
            self?.onFetched?(products)
            
        }
    }
    func favoriteProduct(with productId: String?) {
        guard
            let productId = productId,
            let product = productList.first(where: { $0.product_id == productId})
        else { return }
        
        product.isFavorites?.toggle()
        
        if product.isFavorites == true{
            
            userManager.addToFavorites(product: product){ error in
                if let error = error {
                    print("hata oluştu \(error.localizedDescription)")
                }else {
                    print("başarıya eklendi")
                }
                
            }
        }else{
            userManager.deleteFromFavorites(product: product) {error in
               
                
            }
        }
        
        
        onFavoriteChanged?()
    }
    
    func searchFunc(searchedWord: String) {
        productList = []
        if searchedWord.isEmpty {
            productList = allProductList
        } else {
            productList = allProductList.filter {
                let nameMatch = $0.product_name?.lowercased().contains(searchedWord.lowercased()) ?? false
                let barcodeMatch = $0.barcode?.contains(searchedWord) ?? false
                return nameMatch || barcodeMatch
            }
        }
        onFetched?(productList) 
    }

}

