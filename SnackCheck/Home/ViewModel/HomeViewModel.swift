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
    
    init(firestoreManager:FirestoreManager){
        self.firestoreManager = firestoreManager
    }
    
    
    //MARK: -HelperMethods
    
    func favoriteProduct(with productId: String?) {
        guard
            let productId = productId,
            let product = productList.first(where: { $0.product_id == productId})
        else { return }
        
        product.isFavorites?.toggle()
        firestoreManager.updateFavorite(product_id: productId,favorite: product.isFavorites ?? false)
        
        onFavoriteChanged?()
    }
    
    func FetchAllProduct(){
        firestoreManager.FetchProduct{ [weak self] products in
            self?.productList = products
            self?.allProductList = products
            self?.onFetched?(products)
            
        }
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
        onFetched?(productList) // Arama yaptıktan sonra aynı üründen iki tane görüntüüyorum nasıl düzeltebilrim 
    }

}

