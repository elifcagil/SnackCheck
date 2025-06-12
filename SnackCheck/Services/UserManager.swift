
//
//  UserManager.swift
//  SnackCheck
//
//  Created by ELİF ÇAĞIL on 8.06.2025.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserManager{
    
    let db = Firestore.firestore()

    
    var isUserLogin: Bool {
        return Auth.auth().currentUser != nil //firrbase de bir kullanıcnın daha önce giriş yapıp yapmadığını kontrol eder eğer yapıysa çalışır
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
                
                let favoritesRef = self.db.collection("users").document(uid).collection("favorites")
                
                    if let error = error {
                        print("favoriler koleksiyonu oluşturulamadı \(error.localizedDescription)")
                    }else {
                        print("favoriler koleksiyonu oluşturuldu")
                    }
                    completion(.success(()))
                }
            }
        
    }
    
    func deleteUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oturumu bulunamadı."])))
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        // Reauthenticate before delete
        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            // Firestore'dan kullanıcıyı sil
            let uid = user.uid
            self.db.collection("users").document(uid).delete { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Firebase Authentication'dan kullanıcıyı sil
                user.delete { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success(()))
                }
            }
        }
    }

    

    
    func currenUserInfo(completion: @escaping (Result<User,Error>) -> (Void)){
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oturumu bulunamadı."])))
            return
        }
        let uid = user.uid
        db.collection("users").document(uid).getDocument{ snapshot,error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = snapshot?.data(){
                let name = data["name"] as? String ?? ""
                let id = data["id"] as? String ?? ""
                let surname = data["surname"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let user = User(id: id, name: name, surname: surname, email: email)
                completion(.success(user))
            }
            
        }
        
    }
    //MARK: -FavoritesFunc
    
    func fetchFavorites(completion:@escaping ([Product])-> Void){
        var tempFavorites:[Product] = []
        guard let uid = Auth.auth().currentUser?.uid else {
                print("Kullanıcı oturum açmamış.")
                completion([])
                return
            }
        Task{
            do{
                let snapshot = try await db.collection("users").document(uid).collection("favorites").getDocuments()
                for document in snapshot.documents{
                    let data = document.data()
                    let id = data["product_id"] as? String ?? ""
                    let name = data["product_name"] as? String ?? ""
                    let image = data["product_image"] as? String ?? ""
                    let brand = data["product_brand"] as? String ?? ""
                    let isFavorites = true
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
    func updateFavorites(product_id:String,favorite:Bool){
        guard let uid = Auth.auth().currentUser?.uid else { return }
            
        let tempProduct = "\(product_id)"
        let docRef = db.collection("users").document(uid).collection("favorites").document("\(tempProduct)")
        docRef.updateData(["isFavorites":favorite]){ error in
            if let error = error {
                print ("couldnt change favorite")
            }
            else{
                print("change favorites \(favorite)")
            }
        }
    }
    
    func addToFavorites(product: Product, completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Oturum açmış kullanıcı yok"]))
            return
        }

        let favoriteRef = db.collection("users").document(uid).collection("favorites").document(product.product_id ?? UUID().uuidString)

        let data: [String: Any] = [
            "product_id": product.product_id ?? "",
            "product_name": product.product_name ?? "",
            "product_brand": product.product_brand ?? "",
            "product_image": product.product_image ?? "",
            "category": product.category ?? "",
            "ingeridents": product.ingeridents ?? "",
            "food_values": product.food_values,
            "isFavorites": true,
            "barcode": product.barcode ?? ""
        ]

        favoriteRef.setData(data) { error in
            if let error = error {
                print("Favoriye eklenirken hata: \(error.localizedDescription)")
            }
            completion(error)
        }
    }
    func deleteFromFavorites(product: Product, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oturumu bulunamadı."])))
            return
        }
        
        guard let productID = product.product_id else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Ürün bulunamadı"])))
            return
        }

        let favoriteRef = db.collection("users").document(uid).collection("favorites").document(productID)
        
        favoriteRef.delete { error in
            if let error = error {
                print("Favoriden silinirken hata: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Favoriden başarıyla silindi.")
                completion(.success(()))
            }
           
        }
    }

    
    
    
}
