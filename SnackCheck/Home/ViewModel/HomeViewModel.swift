//
//  AnaSayfaViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 14.04.2025.
//

import Foundation
import FirebaseFirestore

class HomeViewModel{
    
    let db = Firestore.firestore()
    
    var productList : [Product] = []
    var allProductList : [Product] = []
    var onFetched: (([Product]) -> Void)?
    var isSearch = false
    var searchedProduct = [Product]()
    var searchedWord : String = ""
    
    var firestoreManager:FirestoreManager!
    init(firestoreManager:FirestoreManager){
        self.firestoreManager = firestoreManager
    }
    
    
    
    
    func FetchAllProduct(){
        firestoreManager.FetchProduct{ [weak self] products in
            self?.productList = products
            self?.onFetched?(products)
            
        }
        

    }
    func searchFunc(searchedWord: String) {
        productList = []
        if searchedWord.isEmpty {
            productList = allProductList
        } else {
            productList = allProductList.filter {
                $0.product_name?.lowercased().contains(searchedWord.lowercased()) ?? false
            }
        }
        onFetched?(productList) // Arama yaptıktan sonra aynı üründen iki tane görüntüüyorum nasıl düzeltebilrim 
    }

}

