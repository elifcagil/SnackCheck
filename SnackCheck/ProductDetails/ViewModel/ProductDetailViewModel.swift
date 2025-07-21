//
//  ProductDetailViewModel.swift
//  SnackCheck
//
//  Created by ELİF ÇAĞIL on 3.05.2025.
//

import Foundation
class ProductDetailViewModel{
    var buttonName:String?
    var context :String?
    var product: Product?
    
    
    
    
    
    func configure(with product: Product) -> FoodValues {
        let enerji = product.food_values["Enerji"] as? String ?? ""
        let protein = product.food_values["Protein"] as? String ?? "-"
        let yağ = product.food_values["Yağ"] as? String ?? "-"
        let karbonhidrat = product.food_values["Karbonhidrat"] as? String ?? "-"
        let lif = product.food_values ["Lif"] as? String ?? "-"
        let şekerler = product.food_values["Şekerler"] as? String ?? "-"
        let doymuşYağ = product.food_values["Doymuş Yağ"] as? String ?? "-"
        let tuz = product.food_values["Tuz"] as? String ?? "-"
        return FoodValues(energy: enerji, protein: protein, fat: yağ, carbo: karbonhidrat, fiber: lif, sugars: şekerler, satured_fat: doymuşYağ, salt: tuz)
        
    }
    
}
