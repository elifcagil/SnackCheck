//
//  FavoritesTableViewCell.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    
    @IBOutlet var urunBrand: UILabel!
    
    @IBOutlet var urunName: UILabel!
    

    @IBOutlet var urunimage: UIImageView!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
