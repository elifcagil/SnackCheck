//
//  ProductDetailViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 12.04.2025.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    
    @IBOutlet var urunBrand: UILabel!
    
    
    @IBOutlet var urunName: UILabel!
    
    
    @IBOutlet weak var Butonadı: UILabel!
    
    
    @IBOutlet var contentTF: UITextView!
    
    var butonAdiName:String?
    var context :String?
    
    var Urun: Urunler?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let Urun = Urun {
            urunBrand.text = Urun.urun_brand
            urunName.text = Urun.urun_name
        }
        Butonadı.text = butonAdiName
        contentTF.text = context
    }
    


}
