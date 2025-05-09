//
//  User.swift
//  SnackCheck
//
//  Created by ELİF ÇAĞIL on 9.05.2025.
//

import Foundation
class User {
    var id : String
    var name : String
    var surname : String
    var email : String
    
    init( id: String, name: String, surname: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
        self.surname = surname
        
    }
}
