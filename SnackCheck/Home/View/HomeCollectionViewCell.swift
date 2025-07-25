//
//  AnaSayfaCollectionViewCell.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    //MARK: -Properties
    var onTapFavorite: ((String?) -> Void)?
    var product: Product?
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet var productBrandLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBAction func addFavoritesButton(_ sender: UIButton) {
        onTapFavorite?(product?.product_id)
    }
    
    
    //MARK: -HelperMethods
    
    func configuration(_ product: Product) {
        self.product = product
        if let productImage = product.product_image {
            productImageView.image = UIImage(named: productImage)
        }
        let image = product.isFavorites == true ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favoriteButton.setImage(image, for: .normal)
        productNameLabel.text = product.product_name
        productBrandLabel.text = product.product_brand
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
    }
}
