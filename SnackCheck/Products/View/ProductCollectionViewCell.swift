//
//  UrunlerCollectionViewCell.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import UIKit



class ProductCollectionViewCell: UICollectionViewCell {
    
    //MARK: -Properties
    
    var isFavorites : Bool = false
    var product :Product?
    
    @IBOutlet var productImage: UIImageView!
    
    
    @IBOutlet var productBrand: UILabel!
    
    @IBOutlet var productName: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    var onTapFavorite: ((String?) -> Void)?
    
    @IBAction func addbutton(_ sender: UIButton) {
        onTapFavorite?(product?.product_id)
        
    }
    
    
    func configure(_ item:Product){
        self.product = item
        if let image = item.product_image{
            productImage.image = UIImage(named: image)
        }
        let buttonImage = item.isFavorites == true ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favoriteButton.setImage(buttonImage, for: .normal)
        productBrand.text = item.product_brand
        productName.text = item.product_name
        self.layer.borderColor = UIColor.black.cgColor //collectionviewın çevresine çerçeve çizdik.
        self.layer.borderWidth = 0.5 //çerçevenin kalınlığı
        
        
       
    }
}

