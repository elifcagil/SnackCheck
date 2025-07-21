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
    var allProductList : [Product] = []
    var onFetched: (([Product]) -> Void)?
    var category: Category?
    var searchedProduct = [Product]()
    var favList = [Product]()
    var isSearch = false
    var firestoreManager: FirestoreManager!
    var userManager: UserManager!
    var onFavoriteChanged: (() -> Void)?

    
    
    // MARK: - Init
    
    init(fireStoreManager: FirestoreManager,userManager:UserManager) {
        self.firestoreManager = fireStoreManager
        self.userManager = userManager
    }

    // MARK: - Helper Methods
    
    /// Fetch to products by catefory
    /// If category not equal nil return product
    func productToCategory() {
        if let category = category, let categoryName = category.category_name {
            firestoreManager.fetchProductsByCategory(categoryName) {
                [weak self] products in
                self?.productList = products
                self?.allProductList = products
                self?.onFetched?(products)
            }
        }
    }
    
    
    func favoriteProduct(with productId :String?){
        guard let productId = productId,
              let product = productList.first(where: { $0.product_id == productId})
        else {return}
        product.isFavorites?.toggle()
        if product.isFavorites == true{
            userManager.addToFavorites(product: product) { error in
                if let error = error {
                    print("hata oluştur \(error.localizedDescription)")
                }else{
                    print("ürün başarıyla eklendi")
                }
            }
            
        }
        onFavoriteChanged?()
        
        
    }
    func searchCategoryToProduct(searchedWord:String){
        productList = []
        if searchedWord.isEmpty{
            productList = allProductList
        } else {
            productList = allProductList.filter {
                    let nameMatch = $0.product_name?.lowercased().contains(searchedWord.lowercased()) ?? false
                    let barcodeMatch = $0.barcode?.contains(searchedWord) ?? false
                    return nameMatch || barcodeMatch
                }
        }
        onFetched?(productList)
    }
}
