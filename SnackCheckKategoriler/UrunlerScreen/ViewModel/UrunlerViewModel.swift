//
//  UrunlerViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 12.04.2025.
//

import Foundation
class UrunlerViewModel {
    
    
    
    var urunlerListe :[Urunler] = []{
        didSet{
            onItemsUpdated?()
        }
    }
    var onItemsUpdated: (() -> Void)?
    
    

    func FetchuUrunler(){
        
        let u1 = Urunler(urun_id: 1, urun_name: "Yüksek Protein Bar", urun_brand: "ZUBER", urun_resim: "proteinbar", kategori: category())
        let u2 = Urunler(urun_id: 2, urun_name: "Yulaf Bar", urun_brand: "ETİ", urun_resim: "yulafbar", kategori:category())
        let u3 = Urunler(urun_id: 3, urun_name: "Altınbaşak Bisküvi", urun_brand: "ÜLKER", urun_resim: "altınbasak", kategori: category())
        let u4 = Urunler(urun_id: 4, urun_name: "Karabuğday Patlağı", urun_brand: "GLUTENSİZ FABRİKA", urun_resim: "karabugday", kategori: category())
        let u5 = Urunler(urun_id: 5, urun_name: "Kefir", urun_brand: "İÇİM", urun_resim: "kefir", kategori: category())
        let u6 = Urunler(urun_id: 6, urun_name: "Dondurulmuş Kırmızı Meyve", urun_brand: "LAVİ", urun_resim: "kmeyve", kategori: category())

        urunlerListe.append(u1)
        urunlerListe.append(u2)
        urunlerListe.append(u3)
        urunlerListe.append(u4)
        urunlerListe.append(u5)
        urunlerListe.append(u6)
        
    }
    
    
    
    
}
