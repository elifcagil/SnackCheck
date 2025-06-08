//
//  LoginViewModel.swift
//  SnackCheck
//
//  Created by ELİF ÇAĞIL on 15.05.2025.
//
import Foundation

class LoginViewModel{
    
    var firestoreManager: FirestoreManager
    var userManager: UserManager
    init (firestoreManager:FirestoreManager,userManager:UserManager){
        self.firestoreManager = firestoreManager
        self.userManager = userManager
    }
    
   
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        userManager.loginUser(email: email, password: password) { result in
            completion(result)
        }
    }

   
    
    
    
    
    
    
    
    
}
