//
//  AnaSayfaCollectionViewCell.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class AnaSayfaCollectionViewCell: UICollectionViewCell {
    var indexPath: IndexPath?
    var delegate: CollectionCellToViewControllerDelegate?
    var isFavorite = false
    
    @IBOutlet var urunimage: UIImageView!
    
    @IBOutlet var urunBrandLabel: UILabel!
    
    @IBOutlet var urunNameLabel: UILabel!
    
    @IBAction func favorilereEkleButton(_ sender: UIButton) {
        isFavorite.toggle()
        let image = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        sender.setImage(image, for: .normal)
        if let indexPath = indexPath{
            delegate?.favorilereEkle(indexPath: indexPath)
            
        }
        
    }
    
    
    
}


protocol CollectionCellToViewControllerDelegate: AnyObject {
    func favorilereEkle(indexPath: IndexPath)
}
