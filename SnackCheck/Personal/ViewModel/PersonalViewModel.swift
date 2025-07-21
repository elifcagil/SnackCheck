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
    func deleteUser(email:String,password:String, completion: @escaping (Result<Void,Error>) -> Void){
        userManager.deleteUser(email: email, password: password) { result in
            switch result {
            case .success:
                print("Kullanıcı başarıyla silindi.")
                completion(.success(()))
                
            case .failure(let error):
                print("Hata oluştu: \(error.localizedDescription)")
                completion(.failure(error))
            }
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
