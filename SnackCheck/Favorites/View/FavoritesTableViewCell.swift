//
//  FavoritesTableViewCell.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet var productBrand: UILabel!
    
    @IBOutlet var productName: UILabel!

    @IBOutlet var productImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
