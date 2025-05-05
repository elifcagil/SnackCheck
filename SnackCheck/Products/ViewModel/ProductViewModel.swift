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
    
    var firestoreManager:FirestoreManager!
    init(fireStoreManager:FirestoreManager){
        self.firestoreManager = fireStoreManager
    }
    
    func ProductToCategory(category_name:String?){
        if let category = category,let category_name = category.category_name{
            fetchProductsToCategory(byCategory: category_name) { [weak self] products in
                self?.productList = products
                self?.onFetched?(products)
            }
        }
        
    }
    func fetchProductsToCategory(byCategory categoryName: String, completion: @escaping ([Product]) -> Void) {
        var tempList: [Product] = []
        Task {
            do {
                let snapshot = try await db.collection("products")
                    .whereField("category", isEqualTo: categoryName)
                    .getDocuments()
                
                for document in snapshot.documents {
                    let data = document.data()
                    let id = data["product_id"] as? String ?? ""
                    let name = data["product_name"] as? String ?? ""
                    let image = data["product_image"] as? String ?? ""
                    let brand = data["product_brand"] as? String ?? ""
                    let isFavorites = data["isFavorites"] as? Bool ?? false
                    let ingredients = data["ingeridents"] as? String ?? ""
                    let category = data["category"] as? String ?? ""

                    let product = Product(
                        product_id: id,
                        product_name: name,
                        product_brand: brand,
                        product_image: image,
                        category: category,
                        ingeridents: ingredients,
                        food_values: nil,
                        isFavorites: isFavorites
                    )
                    tempList.append(product)
                }
                
                completion(tempList)
            } catch {
                print("Firestore fetch error: \(error.localizedDescription)")
                completion([])
            }
        }
    }
    
    
        
        
        
    }




