//
//  FireStoreManager.swift
//  SnackCheck
//
//  Created by ELİF ÇAĞIL on 1.05.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirestoreManager{
    var tempList: [Product] = []
    
    let db = Firestore.firestore()
    
    //MARK: -PersonalFetch
    
    func FetchPersonel(completion: @escaping ([PersonalModel]) -> Void) {
        var tempList:[PersonalModel] = []
        Task{
            do{
                let snapshot = try await db.collection("personal").order(by: "id").getDocuments()
                for document in snapshot.documents{
                    let data = document.data()
                    let id  = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let personel = PersonalModel(id: id, name: name)
                    tempList.append(personel)
                    
                }
                completion(tempList)
            }catch{
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    //MARK: -CategoriesFunc
    
    func FetchCategories(completion: @escaping ([Category]) -> Void) {
        var tempList: [Category] = []

        Task {
            do {
                let snapshot = try await db.collection("categories").getDocuments()
                for document in snapshot.documents {
                    let data = document.data()
                    let id = data["category_id"] as? String ?? ""
                    let name = data["category_name"] as? String ?? ""
                    let category = Category(category_id: id, category_name: name)
                    tempList.append(category)
                }
                completion(tempList)
            } catch {
                print("Kategori çekilirken hata: \(error.localizedDescription)")
                completion([])
            }
        }
    }
    
    //MARK: -ProductsFunc
    
    func FetchProduct(completion: @escaping ([Product])-> Void) {
        tempList.removeAll()
        Task{
            do{
                let snapshot = try await db.collection("products").getDocuments()
                for document in snapshot.documents{
                    let data = document.data()
                    let id = data["product_id"] as? String ?? ""
                    let name = data["product_name"] as? String ?? ""
                    let image = data["product_image"] as? String ?? ""
                    let brand = data["product_brand"] as? String ?? ""
                    let isFavorites = data["isFavorites"] as? Bool ?? false
                    let ingeridents = data["ingeridents"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let barcode = data["barcode"] as? String ?? ""
                    let food_values = data["food_values"] as? [String:Any] ?? [:]
                    let product = Product(product_id: id,
                                          product_name: name,
                                          product_brand: brand,
                                          product_image: image,
                                          category: category,
                                          ingeridents: ingeridents,
                                          food_values: food_values,
                                          isFavorites: isFavorites,
                                          barcode: barcode)
                            tempList.append(product)
                    print("product fetched:\(product.category!)-\(product.product_name!)-\(product.barcode!)")
                        }
                
                completion(tempList)
            } catch{
                print(error.localizedDescription)
                completion([])
            }
        }
    }
  
    func fetchProductsByCategory(_ category: String, completion: @escaping ([Product])-> Void) {
        var tempList: [Product] = []
        Task {
            do {
                let snapshot = try await db.collection("products")
                    .whereField("category", isEqualTo: category)
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
                    let barcode = data["barcode"] as? String ?? ""
                    let food_values = data["food_values"] as? [String: Any] ?? [:]

                    let product = Product(
                        product_id: id,
                        product_name: name,
                        product_brand: brand,
                        product_image: image,
                        category: category,
                        ingeridents: ingredients,
                        food_values: food_values,
                        isFavorites: isFavorites,
                        barcode: barcode
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
