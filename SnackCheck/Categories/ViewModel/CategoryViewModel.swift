//
//  CategoryViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 15.04.2025.
//

import Foundation

class CategoryViewModel {
    
    //MARK: -Properties
    
    var firestoreManager:FirestoreManager
    var categoriesList : [Category] = []
    var onFetched: (([Category]) -> Void)?
    
    init(firestoreManager: FirestoreManager) {
            self.firestoreManager = firestoreManager
        }
   
    //MARK: -HelperMethods
    func AllCategories(){
        firestoreManager.FetchCategories { [weak self] categories in
            self?.categoriesList = categories
            self?.onFetched?(categories)
        }
    }
}
        
        


    


    
    
    
    
    
    
    

