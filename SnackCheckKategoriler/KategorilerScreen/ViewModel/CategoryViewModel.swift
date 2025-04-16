//
//  CategoryViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 15.04.2025.
//

import Foundation
class CategoryViewModel{
    var kategorilerListe : [category] = [] {
        didSet{
            onItemsUpdated?()
        }
    }
    var onItemsUpdated: (() -> Void)?
    
    
    func FetchKategoriler(){
        
        let k1 = category(category_id: "1", category_name: "Sağlıklı Yaşam")
        let k2 = category(category_id: "2", category_name: "İçecekler")
        let k3 = category(category_id: "3", category_name: "Meyve-Sebze")
        let k4 = category(category_id: "4", category_name: "Atıştırmalıklar")
        let k5 = category(category_id: "5", category_name: "Abur Cubur")
        
        kategorilerListe.append(k1)
        kategorilerListe.append(k2)
        kategorilerListe.append(k3)
        kategorilerListe.append(k4)
        kategorilerListe.append(k5)

       
    }
    
    
    
    
    
    
}
