//
//  Kategoriler.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import Foundation
class Category{
    var category_id : String?
    var category_name: String?
    
    init(){
        
    }
    init(category_id: String,category_name: String) {
        self.category_id = category_id
        self.category_name = category_name
    }
    
    
}
