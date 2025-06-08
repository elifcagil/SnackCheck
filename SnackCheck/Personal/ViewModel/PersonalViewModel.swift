//
//  Untitled.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 21.04.2025.
//
import Foundation
class PersonalViewModel{
    
    //MARK: -Properties
    
    var personelItems :[PersonalModel] = []
    var onFetched : (([PersonalModel]) -> Void)?
    var firestoremanager:FirestoreManager!
    var userManager:UserManager!
   
    
    
    init(firetoreManager:FirestoreManager,userManager:UserManager){
        self.firestoremanager = firetoreManager
        self.userManager = userManager
    }
    
    //MARK: -HelperMethods
    
    func PersonelInfo(){
        firestoremanager.FetchPersonel{ [weak self] items in
            self?.personelItems = items
            self?.onFetched?(items)
        }
    }
    func deleteUser(completion: @escaping (Result<Void,Error>) -> Void){
        userManager.deleteUser{ result in
            completion(result)
        }
    }
    func logOutUser(completion:@escaping (Result <Void,Error>) -> Void ){
        userManager.logOutUser{ result in
            completion(result)
        }
    }
    func currenUserInfo(completion:@escaping (Result<User,Error>) -> Void){
        userManager.currenUserInfo{ user in
            completion(user)
            
        }
    }
}
