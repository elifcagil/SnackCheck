//
//  AnaSayfaViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 14.04.2025.
//

import Foundation
import FirebaseFirestore
class HomeViewModel{
    
    
    
    let db = Firestore.firestore()
    
    
    
    var productList : [Product] = []
    var allProductList : [Product] = []
    var onFetched: (([Product]) -> Void)?
    
    
    func FetchUrunler(){

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
                    let product = Product(product_id: id, product_name: name, product_brand: brand, product_image: image, category: nil, ingeridents: ingeridents, food_values: food_values,isFavorites: nil)
                    allProductList.append(product)
                    print("bütün ürünler \(product.product_name)")
                    
                }
                self.productList = allProductList
                onFetched?(productList)
            }catch{
                print(error.localizedDescription)
            }
        }
        

    }
    func aramaYap(searchedWord: String) {
        productList = []
        if searchedWord.isEmpty {
            productList = allProductList
        } else {
            productList = allProductList.filter {
                $0.product_name?.lowercased().contains(searchedWord.lowercased()) ?? false
            }
        }
        onFetched?(productList) // Arama yaptıktan sonra aynı üründen iki tane görüntüüyorum nasıl düzeltebilrim 
    }

}

