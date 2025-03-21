//
//  AnalizViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 16.03.2025.
//

import UIKit

class AnalizViewController: UIViewController {
    
    var urun :Urunler?
    
    @IBOutlet var urunBrand: UILabel!
    
    @IBOutlet var analiztf: UITextView!
    @IBOutlet var sayfaBaslik: UILabel!
    @IBOutlet var urunAdi: UILabel!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        APIService.shared.yorumlaIcindekilerGemini(icerik: "Şeker, Palm Yağı, Kakao Kitlesi") { yorum in
            DispatchQueue.main.async {
                self.analiztf.text = yorum ?? "Yorum alınamadı."
            }
        }
        
        if let u = urun {
            urunBrand.text = u.urun_brand
            urunAdi.text = u.urun_name
            
        }
        
        
        
        
    }
}
