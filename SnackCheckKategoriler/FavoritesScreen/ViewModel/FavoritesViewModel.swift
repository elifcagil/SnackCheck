//
//  FavoritesViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 14.04.2025.
//

import Foundation
class FavoritesViewModel{
    
    
    var favorilerList : [Urunler] = []{
        didSet{
            onItemsUpdated?()
        }
    }
    var onItemsUpdated: (() -> Void)?
    
    
    func FetchFavorites(){
        
        let u1 = Urunler(urun_id: 1, urun_name: "Yüksek Protein Bar", urun_brand: "ZUBER", urun_resim: "proteinbar", kategori: category(),icindekiler: "abcabcabc",besindegerleri: "kkkkkkkkkk")
        let u2 = Urunler(urun_id: 2, urun_name: "Yulaf Bar", urun_brand: "ETİ", urun_resim: "yulafbar", kategori:category(),icindekiler: "eeeeeeee",besindegerleri: "ddddddd")
       
        favorilerList.append(u1)
        favorilerList.append(u2)
   
        
    }
    
    func deleteFavorite(item: Urunler) {
        if let index = favorilerList.firstIndex(where: { $0.urun_id == item.urun_id }) {
            favorilerList.remove(at: index)
            onItemsUpdated?()
        }
    }

    
    
    
}
