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
    
    //MARK: -UserFunc

    func createUser(name:String,surname:String, email:String, password:String,completion:@escaping (Result<Void,Error>)->(Void)){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error{
                print("kayıt başarısız")
                completion(.failure(error))
                return
            }
            guard let uid = authResult?.user.uid else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"uid alınamadı"])))
                return
            }
            let userData:[String:Any] = [
                "id" : uid,
                "name" : name,
                "surname" : surname,
                "email" : email,
                "createdAt" : FieldValue.serverTimestamp()
            ]
            self.db.collection("users").document(uid).setData(userData) { error in
                if let error = error {
                    Auth.auth().currentUser?.delete(completion: nil)
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
            }
        }
    }
    
   
    func loginUser(email:String, password:String,completion:@escaping(Result<Void,Error>)->(Void)){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("kullanıcı girişi yapılamadı")
                completion(.failure(error))
                return
            }
            guard let uid = authResult?.user.uid else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"kullanıcı id sine erişilemedi"])))

                return
            }
            
            let userRef = self.db.collection("users").document(uid)
            userRef.getDocument { document , error in
                if let error = error {
                    try? Auth.auth().signOut()
                    completion(.failure(error))
                    return
                }
                guard let document = document,document.exists else {
                    try? Auth.auth().signOut()
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"kullanıcı firestorede bulunamadı"])))
                    return
                }
                
                completion(.success(()))
            }
            
        }
       
    }

    func logOutUser(completion:@escaping (Result <Void ,Error>) -> Void){
        do{
            try Auth.auth().signOut()
            completion(.success(()))
        }catch let signOutError {
            completion(.failure(signOutError))
            
        }
    }
    
    func deleteUser(completion: @escaping (Result<Void,Error>) -> Void){
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oturumu bulunamadı."])))
            return
        }
        let uid = user.uid
        db.collection("users").document(uid).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            user.delete{ error in
                if let error = error {
                    print("Kullanıcı silinemedi \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
            }
        }
    }
    //MARK: -FavoritesFunc
    
    func fetchFavorites(completion:@escaping ([Product])-> Void){
        var tempFavorites:[Product] = []
        Task{
            do{
                let snapshot = try await db.collection("products").whereField("isFavorites", isEqualTo: true).getDocuments()
                for document in snapshot.documents{
                    let data = document.data()
                    let id = data["product_id"] as? String ?? ""
                    let name = data["product_name"] as? String ?? ""
                    let image = data["product_image"] as? String ?? ""
                    let brand = data["product_brand"] as? String ?? ""
                    let isFavorites = data["isFavorites"] as? Bool ?? false
                    let ingredients = data["ingeridents"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let barcode = data["barcode"] as? String ?? ""
                    let food_values = data["food_values"] as? [String:Any] ?? [:]

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
                    tempFavorites.append(product)
                }
                completion(tempFavorites)
                
            }catch{
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    func updateFavorite(product_id:String,favorite:Bool){
        
        let product = tempList.first(where: { $0.product_id == product_id})
        let tempProduct = "product\(product_id)"
        let docRef = db.collection("products").document(tempProduct)
        docRef.updateData(["isFavorites":favorite]){ error in
            if let error = error {
                print ("couldnt change favorite")
            }
            else{
                print("change favorites \(favorite)")
            }
        }
    }
}
