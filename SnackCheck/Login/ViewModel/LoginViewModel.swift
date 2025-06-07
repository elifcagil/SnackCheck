//
//  LoginViewModel.swift
//  SnackCheck
//
//  Created by ELİF ÇAĞIL on 15.05.2025.
//
import Foundation

class LoginViewModel{
    var firestoreManager: FirestoreManager
    init (firestoreManager:FirestoreManager){
        self.firestoreManager = firestoreManager
    }
    
   
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        firestoreManager.loginUser(email: email, password: password) { result in
            completion(result)
        }
    }

   
    
    
    
    
    
    
    
    
}
