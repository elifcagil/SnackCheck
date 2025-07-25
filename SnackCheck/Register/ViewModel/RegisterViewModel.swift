//
//  RegisterViewModel.swift
//  SnackCheck
//
//  Created by ELİF ÇAĞIL on 7.06.2025.
//

import Foundation
class RegisterViewModel{
    
    
    
    var firestoreManager: FirestoreManager
    var userManager: UserManager
    init (firestoreManager:FirestoreManager,userManager:UserManager){
        self.firestoreManager = firestoreManager
        self.userManager = userManager
    }
    
    
    func register(name:String,surname:String,email:String,password:String,completion:@escaping (Result <Void,Error>)->(Void)){
        userManager.createUser(name: name, surname: surname, email: email, password: password){ result in
            completion(result)
        }
    }
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        userManager.loginUser(email: email, password: password) { result in
            completion(result)
        }
    }
    
}
