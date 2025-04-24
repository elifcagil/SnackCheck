//
//  CategoryViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 15.04.2025.
//

import Foundation
class CategoryViewModel{
    var kategorilerListe : [Category] = [] 
    var onFetched: (([Category]) -> Void)?

    
    
    func FetchKategoriler(){
        
        let k1 = Category(category_id: "1", category_name: "Sağlıklı Yaşam")
        let k2 = Category(category_id: "2", category_name: "İçecekler")
        let k3 = Category(category_id: "3", category_name: "Meyve-Sebze")
        let k4 = Category(category_id: "4", category_name: "Atıştırmalıklar")
        let k5 = Category(category_id: "5", category_name: "Abur Cubur")
        
        kategorilerListe.append(k1)
        kategorilerListe.append(k2)
        kategorilerListe.append(k3)
        kategorilerListe.append(k4)
        kategorilerListe.append(k5)
        onFetched?(kategorilerListe)
       
    }
    
    
    
    
    
    
}
