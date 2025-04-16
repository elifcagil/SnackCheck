//
//  AnaSayfaViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 14.04.2025.
//

import Foundation
class AnaSayfaViewModel{
    
    var urunlerListe : [Urunler] = []{
        didSet{
            onItemsUpdated?()
        }
    }
    var onItemsUpdated: (() -> Void)?
    
    
    
    
    
    func FetchUrunler(){
        
        let u1 = Urunler(urun_id: 1, urun_name: "Yüksek Protein Bar", urun_brand: "ZUBER", urun_resim: "proteinbar", kategori: category(),icindekiler: "abcabcabc",besindegerleri: "kkkkkkkkkk")
        let u2 = Urunler(urun_id: 2, urun_name: "Yulaf Bar", urun_brand: "ETİ", urun_resim: "yulafbar", kategori:category(),icindekiler: "eeeeeeee",besindegerleri: "ddddddd")
        let u3 = Urunler(urun_id: 3, urun_name: "Altınbaşak Bisküvi", urun_brand: "ÜLKER", urun_resim: "altınbasak", kategori: category(),icindekiler: "ffffffff",besindegerleri: "ggggggg")
        let u4 = Urunler(urun_id: 4, urun_name: "Karabuğday Patlağı", urun_brand: "GLUTENSİZ FABRİKA", urun_resim: "karabugday", kategori: category(),icindekiler: "hhhhhhh",besindegerleri: "cccccccc")
        let u5 = Urunler(urun_id: 5, urun_name: "Kefir", urun_brand: "İÇİM", urun_resim: "kefir", kategori: category(),icindekiler: "ttttttt",besindegerleri: "aaaaaaaa")
        let u6 = Urunler(urun_id: 6, urun_name: "Dondurulmuş Kırmızı Meyve", urun_brand: "LAVİ", urun_resim: "kmeyve", kategori: category(),icindekiler: "hohohohoooh",besindegerleri: "ehhehehehehhee")

        urunlerListe.append(u1)
        urunlerListe.append(u2)
        urunlerListe.append(u3)
        urunlerListe.append(u4)
        urunlerListe.append(u5)
        urunlerListe.append(u6)

    }
    func aramaYap(aramaKelimesi:String){
        
        let arananUrunler = urunlerListe.filter{
            $0.urun_name?.lowercased().contains(aramaKelimesi.lowercased()) ?? false
            
        }
        urunlerListe = arananUrunler
    
    }
}
