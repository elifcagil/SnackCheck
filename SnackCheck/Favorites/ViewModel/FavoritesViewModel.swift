//
//  FavoritesViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 14.04.2025.
//

import Foundation

class FavoritesViewModel{
    
    var favoritesList : [Product] = []
    var onFetched : (([Product]) -> Void)?
    var firestoreManaher:FirestoreManager
    
    init(firestoreManager:FirestoreManager){
        self.firestoreManaher = firestoreManager
    }
    
    func FetchFavorites() {
    
        firestoreManaher.fetchFavorites{ [weak self] favorites in
            self?.favoritesList = favorites
            self?.onFetched?(favorites)
        }
    }
    
    
    
    
    
    
    
    
    func deleteFavorite(item: Product) {
        guard let id = item.product_id else { return}
        if let index = favoritesList.firstIndex(where: { $0.product_id == id }) {
            firestoreManaher.updateFavorite(product_id: id , favorite: false)
            favoritesList.remove(at: index)
            onFetched?(favoritesList)
        }
    }
}


