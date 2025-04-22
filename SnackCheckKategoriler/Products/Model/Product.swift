//
//  Filmler.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import Foundation

class Product{
    
    var product_id : Int?
    var product_name : String?
    var product_brand : String?
    var product_image: String?
    var category : Category?
    var ingeridents: String?
    var food_values: String?
    
    
    
    
    init(){
        
    }
    
    init(product_id:Int,product_name:String,product_brand:String,product_image:String,category:Category,ingeridents:String,food_values:String){
        self.product_id = product_id
        self.product_name = product_name
        self.product_brand = product_brand
        self.product_image = product_image
        self.category = category
        self.ingeridents = ingeridents
        self.food_values = food_values
    
    }
    
    
    
}
