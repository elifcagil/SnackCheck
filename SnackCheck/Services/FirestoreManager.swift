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
                completion([]) // hata durumunda boş array dön
            }
        }
    }
        

        
    }

    

