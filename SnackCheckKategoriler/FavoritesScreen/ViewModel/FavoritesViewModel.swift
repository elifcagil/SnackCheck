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
        
        let u1 = Urunler(urun_id: 1, urun_name: "Yüksek Protein Bar", urun_brand: "ZUBER", urun_resim: "proteinbar", kategori: category())
        
        favorilerList.append(u1)
        let u2 = Urunler(urun_id: 1, urun_name: "Yüksek Protein Bar", urun_brand: "ZUBER", urun_resim: "proteinbar", kategori: category())
        
        favorilerList.append(u2)
        let u3 = Urunler(urun_id: 1, urun_name: "Yüksek Protein Bar", urun_brand: "ZUBER", urun_resim: "proteinbar", kategori: category())
        
        favorilerList.append(u3)
        let u4 = Urunler(urun_id: 1, urun_name: "Yüksek Protein Bar", urun_brand: "ZUBER", urun_resim: "proteinbar", kategori: category())
        
        favorilerList.append(u4)
        
        
    }
    
    func deleteFavorite(item: Urunler) {
        if let index = favorilerList.firstIndex(where: { $0.urun_id == item.urun_id }) {
            favorilerList.remove(at: index)
            onItemsUpdated?()
        }
    }

    
    
    
}
