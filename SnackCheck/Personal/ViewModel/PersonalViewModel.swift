//
//  Untitled.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 21.04.2025.
//
import Foundation
class PersonalViewModel{
    
    var personelItems :[PersonalModel] = []
    var onFetched : (([PersonalModel]) -> Void)?
    var firestoremanager:FirestoreManager!
    
    init(firetoreManager:FirestoreManager){
        self.firestoremanager = firetoreManager
    }
    
    func PersonelInfo(){
        firestoremanager.FetchPersonel{ [weak self] items in
            self?.personelItems = items
            self?.onFetched?(items)
            
        }
    }
    
    func deleteUser(completion: @escaping (Result<Void,Error>) -> Void){
        firestoremanager.deleteUser{ result in
            completion(result)
            
        }
        
    }
}
