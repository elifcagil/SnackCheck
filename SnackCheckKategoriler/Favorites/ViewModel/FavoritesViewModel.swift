//
//  FavoritesViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 14.04.2025.
//

import Foundation
class FavoritesViewModel{
    
    
    var favorilerList : [Product] = []{
        didSet{
            onItemsUpdated?()
        }
    }
    var onItemsUpdated: (() -> Void)?
    
    
    func FetchFavorites(){
        
        let u1 = Product(product_id: 1, product_name: "Yüksek Protein Bar", product_brand: "ZUBER", product_image: "proteinbar", category: Category(), ingeridents: "abcabcabc", food_values: "kkkkk")
                         
                         
                         
        let u2 = Product(product_id: 2, product_name: "Yulaf Bar", product_brand: "ETİ", product_image: "yulafbar", category:Category(),ingeridents: "eeeeeeee",food_values: "ddddddd")
       
        favorilerList.append(u1)
        favorilerList.append(u2)
   
        
    }
    
    func deleteFavorite(item: Product) {
        if let index = favorilerList.firstIndex(where: { $0.product_id == item.product_id }) {
            favorilerList.remove(at: index)
            onItemsUpdated?()
        }
    }

    
    
    
}
