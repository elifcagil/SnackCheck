//
//  İcindekilerViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 16.03.2025.
//

import UIKit

class İcindekilerViewController: UIViewController {

    
    @IBOutlet var urunBrand: UILabel!
    
    @IBOutlet var urunAd: UILabel!
    
    @IBOutlet var icindekilerbaslik: UILabel!
    
    
    @IBOutlet var yorumLabel: UITextView!
    
    
    var urun: Urunler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        if let u = urun{
            urunBrand.text = u.urun_brand
            urunAd.text = u.urun_name
        }
        
        
        
        
    }
    

  

}
