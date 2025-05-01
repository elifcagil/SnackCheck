//
//  UrunlerCollectionViewCell.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import UIKit



class ProductCollectionViewCell: UICollectionViewCell {
    
    var cellProtocol : ProductCellCollectionViewCellProtocol? //protkol ile diğer sayfadaki fonksiyona veri göndermek için bu protokol sınıfı türünde bir nesne oluşturduk.
    var indexPath:IndexPath? //tıklanılan collectionviewın indexini aldık
    var isFavorites : Bool = false
    var favList : [Product] = []
    
    @IBOutlet var productImage: UIImageView!
    
    
    @IBOutlet var productBrand: UILabel!
    
    @IBOutlet var productName: UILabel!
    
    
    @IBAction func addbutton(_ sender: UIButton) {
    
        
        isFavorites.toggle()
        let imageName = isFavorites ? "star.fill" : "star"
        (sender as AnyObject).setImage(UIImage(systemName: imageName), for: .normal)
        if let indexPath = indexPath {
            
            cellProtocol?.add_Favorite(indexPath:indexPath) //protok ile eriştiğimiz favorilere ekle fonskiyonuna tıklanılan itemin indexini parametre olarak gönderdik.
            
            
            
        }
    }
}

protocol ProductCellCollectionViewCellProtocol{ // viewcontrollerda tanımlanan bir fonksiyon var bu fonksiyona erişmek istediğimizi ve butona tıklandığında o fonksiyona veri göndermek istediğimzi varsayalım.başka sınıfta oluşturulmuş fonksiyonu bu sınıfta kullanabilmemiz için
    func add_Favorite(indexPath:IndexPath) //veri gönderebilmek için bir ara fonksiyon oluşturduk.
    
    
}

