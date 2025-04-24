//
//  UrunlerViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 12.04.2025.
//

import Foundation

class ProductViewModel {
    
    
    
    var urunlerListe :[Product] = []
    var onFetched: ((Product) -> Void)?
    
    func FetchuUrunler(){
        
        let u1 = Product(product_id: 1, product_name: "Yüksek Protein Bar", product_brand: "ZUBER", product_image: "yulafbar", category: Category(),ingeridents: "abcabcabc",food_values: "kkkkkkkkkk")
        
        let u2 = Product(product_id: 1, product_name: "Yulaf Bar", product_brand: "ETİ", product_image: "proteinbar", category: Category(),ingeridents: "eeeeeeee",food_values: "ddddddd")
        
        let u3 = Product(product_id: 1, product_name: "Altınbaşak Bisküvi", product_brand: "ÜLKER", product_image: "altınbasak", category: Category(),ingeridents: "ffffffff",food_values: "ggggggg")
        
        let u4 = Product(product_id: 1, product_name: "Karabuğday Patlağı", product_brand: "GLUTENSİZ FABRİKA", product_image: "karabugday", category: Category(),ingeridents: "hhhhhhh",food_values: "cccccccc")
        
        let u5 = Product(product_id: 1, product_name: "Kefir", product_brand: "İÇİM", product_image: "kefir", category: Category(),ingeridents: "ttttttt",food_values: "aaaaaaaa")
        
        let u6 = Product(product_id: 1, product_name: "Dondurulmuş Kırmızı Meyve", product_brand: "LAVİ", product_image: "kmeyve", category: Category(),ingeridents: "hohohohoooh",food_values: "ehhehehehehhee")
        
        urunlerListe.append(u1)
        urunlerListe.append(u2)
        urunlerListe.append(u3)
        urunlerListe.append(u4)
        urunlerListe.append(u5)
        urunlerListe.append(u6)
        
    }
}
