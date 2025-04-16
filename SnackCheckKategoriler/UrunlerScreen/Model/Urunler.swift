//
//  Filmler.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import Foundation
class Urunler{
    var urun_id : Int?
    var urun_name : String?
    var urun_brand : String?
    var urun_resim: String?
    var kategori : category?
    
    
    init(){
        
    }
    
    init(urun_id:Int,urun_name:String,urun_brand:String,urun_resim:String,kategori:category){
        self.urun_id = urun_id
        self.urun_name = urun_name
        self.urun_brand = urun_brand
        self.urun_resim = urun_resim
        self.kategori = kategori
    
    }
    
    
    
}
