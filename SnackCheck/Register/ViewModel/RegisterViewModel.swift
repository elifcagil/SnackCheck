//
//  RegisterViewModel.swift
//  SnackCheck
//
//  Created by ELİF ÇAĞIL on 7.06.2025.
//

import Foundation
class RegisterViewModel{
    
    
    var firestoreManager: FirestoreManager
    init (firestoreManager:FirestoreManager){
        self.firestoreManager = firestoreManager
    }
    
    
    func register(name:String,surname:String,email:String,password:String,completion:@escaping (Result <Void,Error>)->(Void)){
        firestoreManager.createUser(name: name, surname: surname, email: email, password: password){ result in
            completion(result)
        }
    }
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        firestoreManager.loginUser(email: email, password: password) { result in
            completion(result)
        }
    }
    
}
