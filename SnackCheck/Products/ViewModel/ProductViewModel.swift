//
//  UrunlerViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 12.04.2025.
//

import Foundation
import FirebaseFirestore

class ProductViewModel {
    
    let db = Firestore.firestore()
    
    var productList :[Product] = []
    var onFetched: (([Product]) -> Void)?
    var category : Category?
    var searchedProduct = [Product]()
    var favList = [Product]()
    var isSearch = false
    
    func FetchuUrunler(){ //kategoriye göre filtreleme yaptığım bir fonksiyon yazmam gerekiyor.
        Task{
            do{
                let snapshot = try await db.collection("products").getDocuments()
                for document in snapshot.documents {
                    let data = document.data()
                    let id = data["product_id"] as? String ?? ""
                    let name = data["product_name"] as? String ?? ""
                    let brand = data["product_brand"] as? String ?? ""
                    let image = data["product_image"] as? String ?? ""
                    let ingeridents = data["ingeridents"] as? String ?? ""
                    let food_values = data["food_values"] as? String ?? ""
                    //let category = data["category"] as? Category ?? ""
                    let product = Product(product_id: id, product_name: name, product_brand: brand, product_image: image, category: nil, ingeridents: ingeridents, food_values: food_values, isFavorites: nil)
                    productList.append(product)
                    print("bütün ürünler \(product.product_name)")
                }
                onFetched?(productList)
            }catch{
                print(error.localizedDescription)
            }
        }
        
    }
}

//firestore manager classı --> firestore methodları viewmodelde nesne oluştur kullan --> modülerlik

