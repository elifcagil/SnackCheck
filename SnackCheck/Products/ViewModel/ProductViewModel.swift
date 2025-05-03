//
//  UrunlerViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 12.04.2025.
//

import Foundation

class ProductViewModel {
    
    
    var productList :[Product] = []
    var onFetched: (([Product]) -> Void)?
    var category : Category?
    var searchedProduct = [Product]()
    var favList = [Product]()
    var isSearch = false
    
    var firestoreManager:FirestoreManager!
    init (firestoreManager:FirestoreManager){
        self.firestoreManager = firestoreManager
        
    }
    
    func FetchAllProduct(){
        firestoreManager.FetchProduct{ [weak self] products in
            self?.productList = products
            self?.onFetched?(products)
            
        }
        
        
        
    }
}



