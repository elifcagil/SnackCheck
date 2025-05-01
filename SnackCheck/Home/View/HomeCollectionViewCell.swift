//
//  AnaSayfaCollectionViewCell.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    var indexPath: IndexPath?
    var delegate: CollectionCellToViewControllerDelegate?
    var isFavorite = false
    
    @IBOutlet var productImage: UIImageView!
    
    @IBOutlet var productBrandLabel: UILabel!
    
    @IBOutlet var productNameLabel: UILabel!
    
    @IBAction func addFavoritesButton(_ sender: UIButton) {
        isFavorite.toggle()
        let image = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        sender.setImage(image, for: .normal)
        if let indexPath = indexPath{
            delegate?.addFavorite(indexPath: indexPath)
        }
    }
}

protocol CollectionCellToViewControllerDelegate: AnyObject {
    func addFavorite(indexPath: IndexPath)
}
