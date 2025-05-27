//
//  UrunlerViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 12.04.2025.
//

import Foundation

class ProductViewModel {
    
    //MARK: - Properties
    
    var productList: [Product] = []
    var onFetched: (() -> Void)?
    var category: Category?
    var searchedProduct = [Product]()
    var favList = [Product]()
    var isSearch = false
    var firestoreManager: FirestoreManager!
    var onFavoriteChanged: (() -> Void)?
    
    
    // MARK: - Init
    
    init(fireStoreManager: FirestoreManager) {
        self.firestoreManager = fireStoreManager
    }

    // MARK: - Helper Methods
    
    /// Fetch to products by catefory
    /// If category not equal nil return product
    func productToCategory() {
        if let category = category, let categoryName = category.category_name {
            firestoreManager.fetchProductsByCategory(categoryName) {
                [weak self] products in
                self?.productList = products
                self?.onFetched?()
            }
        }
    }
    
    
    func favoriteProduct(with productId :String?){
        guard let productId = productId,
              let product = productList.first(where: { $0.product_id == productId})
        else {return}
        product.isFavorites?.toggle()
        firestoreManager.updateFavorite(product_id: productId, favorite: product.isFavorites ?? false)
        onFavoriteChanged?()
        
        
    }
}
