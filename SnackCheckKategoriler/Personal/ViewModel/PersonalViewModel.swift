//
//  Untitled.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 21.04.2025.
//
import Foundation
class PersonalViewModel{
    
    var personelItems :[String] = []
    var onFetched : (([String]) -> Void)?
    
    
    func PersonelInfo(){
        
        
        let items = ["Hesap Ayarları","Kişi Bilgileri","Bildirimler","Sağlık Verileri","Oturumu Kapat"]
        personelItems = items
        onFetched?(personelItems)
        
        
    }
}
