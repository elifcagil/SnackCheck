//
//  CategoryViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 15.04.2025.
//

import Foundation
import FirebaseFirestore

class CategoryViewModel{
    
    let db = Firestore.firestore() //managere gidicek
    
    
    var categoriesList : [Category] = []
    var onFetched: (([Category]) -> Void)?

    
    
    func FetchKategoriler(){
        Task{
            do{
                let docSnapshot = try await db.collection("categories").getDocuments()
                for document in docSnapshot.documents{
                    let data = document.data()
                    let id = data["category_id"] as? String ?? "0"
                    let name = data["category_name"] as? String ?? "boş"
                        let categories = Category(category_id: id, category_name: name)
                    categoriesList.append(categories)
                    print("bütün kategoriler bu şekilde \(categories.category_name)")
                        
                }
                onFetched?(categoriesList)
            }catch{
                print(error.localizedDescription)
            }
        }
        
        
       
    }
    
    
    
    
    
    
}
