//
//  FireStoreManager.swift
//  SnackCheck
//
//  Created by ELİF ÇAĞIL on 1.05.2025.
//

import Foundation
import FirebaseFirestore

class FirestoreManager{
    
    let db = Firestore.firestore()
    
    
    func FetchPersonel(completion: @escaping ([PersonalModel]) -> Void) {
        var tempList:[PersonalModel] = []
        Task{
            do{
                let snapshot = try await db.collection("personal").getDocuments()
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
    
    
    
    
    func FetchProduct(completion: @escaping ([Product])-> Void) {
        var tempList: [Product] = []
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
                            let product = Product(product_id: id, product_name: name, product_brand: brand, product_image: image, category: category, ingeridents: ingeridents, food_values: nil, isFavorites: isFavorites)
                            tempList.append(product)
                    print("product fetched:\(product.category)-\(product.product_name)")
                        }
                
                completion(tempList)
            } catch{
                print(error.localizedDescription)
                completion([])
            }
        }
        
    }
        

        
    }

    

