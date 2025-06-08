
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
                completion(.success(()))
            }
        }
    }
    
    func deleteUser(completion: @escaping (Result<Void,Error>) -> Void){
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oturumu bulunamadı."])))
            return
        }
        let uid = user.uid
        db.collection("users").document(uid).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            user.delete{ error in
                if let error = error {
                    print("Kullanıcı silinemedi \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
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
    
    
    
    
    
    
}
