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
    
    func FetchFavorites() {
    
                let u1 = Product(product_id: "1", product_name: "Yüksek Protein Bar", product_brand: "ZUBER", product_image: "proteinbar", category: "Atıştırmalık", ingeridents: "abcabcabc", food_values: "kkkkk",isFavorites: true)
                                 
                let u2 = Product(product_id: "2", product_name: "Yulaf Bar", product_brand: "ETİ", product_image: "yulafbar", category:"İçecekler",ingeridents: "eeeeeeee",food_values: "ddddddd",isFavorites: true)
               
                favoritesList.append(u1)
                favoritesList.append(u2)
                onFetched?(favoritesList)
    }
    
    func deleteFavorite(item: Product) {
        if let index = favoritesList.firstIndex(where: { $0.product_id == item.product_id }) {
            favoritesList.remove(at: index)
            onFetched?(favoritesList)
        }
    }
}


