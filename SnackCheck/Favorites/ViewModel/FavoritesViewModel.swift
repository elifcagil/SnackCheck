//
//  FavoritesViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 14.04.2025.
//

import Foundation

class FavoritesViewModel{
    
    //MARK: -Properties
    
    var favoritesList : [Product] = []
    var onFetched : (([Product]) -> Void)?
    var firestoreManaher:FirestoreManager
    var userManager:UserManager
    
    init(firestoreManager:FirestoreManager,userManager:UserManager){
        self.firestoreManaher = firestoreManager
        self.userManager = userManager
    }
    
    //MARK: -HelperMethods
    
    func FetchFavorites() {
        userManager.fetchFavorites{ [weak self] favorites in
            self?.favoritesList = favorites
            self?.onFetched?(favorites)
        }
    }
    
    func deleteFavorite(item: Product) {
        userManager.deleteFromFavorites(product: item) { result in
            switch result {
            case .success:
                print("ürün favorilerden silindi")
                self.FetchFavorites()
                
            case .failure:
                print("ürün favorilerden silinemedi")
                
            }
        }
    }
}

