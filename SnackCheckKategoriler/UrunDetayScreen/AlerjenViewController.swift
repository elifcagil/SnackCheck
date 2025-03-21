//
//  AlerjenViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 16.03.2025.
//

import UIKit

class AlerjenViewController: UIViewController {
    var urun :Urunler?

    @IBOutlet var urunBrand: UILabel!
    
    @IBOutlet var urunAd: UILabel!
    
    @IBOutlet var sayfaBaslik: UILabel!
    
    
    @IBOutlet var analiztf: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let u = urun {
            urunBrand.text = u.urun_brand
            urunAd.text = u.urun_name
        }



    }
    


}
