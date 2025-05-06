//
//  FavoritesViewModel.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 14.04.2025.
//

import Foundation
import FirebaseFirestore
class FavoritesViewModel{
    
    
    let db = Firestore.firestore()
    
    
    var favoritesList : [Product] = []
    var onFetched : (([Product]) -> Void)?
    
    
    func FetchFavorites() {
        //        Task {
        //            do {
        //                let snapshot = try await db.collection("favorites").getDocuments()
        //                var tempList: [Product] = []
        //
        //                for document in snapshot.documents {
        //                    let data = document.data()
        //                    guard let product_id = data["product_id"] as? String, !product_id.isEmpty else {
        //                        print("Geçersiz product_id")
        //                        continue
        //                    }
        //
        //                    do {
        //                        let docSnapshot = try await db.collection("products").document(product_id).getDocument()
        //                        guard let veri = docSnapshot.data() else {
        //                            print("Ürün bulunamadı: \(product_id)")
        //                            continue
        //                        }
        //
        //                        let product_name = veri["product_name"] as? String ?? ""
        //                        let product_brand = veri["product_brand"] as? String ?? ""
        //                        let product_image = veri["product_image"] as? String ?? ""
        //                        let ingeridents = veri["ingeridents"] as? String ?? ""
        //                        let food_values = veri["food_values"] as? String ?? ""
        //
        //                        let favoriteProduct = Product(
        //                            product_id: product_id,
        //                            product_name: product_name,
        //                            product_brand: product_brand,
        //                            product_image: product_image,
        //                            category: nil,
        //                            ingeridents: ingeridents,
        //                            food_values: food_values,
        //                            isFavorites: true
        //                        )
        //
        //                        tempList.append(favoriteProduct)
        //                    } catch {
        //                        print("Ürün detayını çekerken hata: \(error.localizedDescription)")
        //                    }
        //                }
        //
        //                favorilerList = tempList
        //                onFetched?(favorilerList)
        //            } catch {
        //                print("Favorileri çekerken hata: \(error.localizedDescription)")
        //            }
        //        }
        //    }
        //
        //
        
        
        
        
        
        
        
        
        
                let u1 = Product(product_id: "1", product_name: "Yüksek Protein Bar", product_brand: "ZUBER", product_image: "proteinbar", category: "Atıştırmalık", ingeridents: "abcabcabc", food_values: "kkkkk",isFavorites: true)
                                 
                                 
                                 
                let u2 = Product(product_id: "2", product_name: "Yulaf Bar", product_brand: "ETİ", product_image: "yulafbar", category:"İçecekler",ingeridents: "eeeeeeee",food_values: "ddddddd",isFavorites: true)
               
                favoritesList.append(u1)
                favoritesList.append(u2)
                onFetched?(favoritesList)
        //
                
        
    }
    func deleteFavorite(item: Product) {
        if let index = favoritesList.firstIndex(where: { $0.product_id == item.product_id }) {
            favoritesList.remove(at: index)
            onFetched?(favoritesList)
        }
    }

    
    
    
}

/* kalıcı bir şekilde Favoriler listesindeki itemlara göre kontrol yapan ve buna göre butonun resmini değiştiren kod !!
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UrunlerCell", for: indexPath) as! UrunlerCollectionViewCell

    let isFavorited = favoriUrunler[indexPath.item]  // Favori durumu kontrolü
    let imageName = isFavorited ? "star.fill" : "star"
    cell.favoriButton.setImage(UIImage(systemName: imageName), for: .normal)

    cell.hucreProtocol = self
    cell.indexPath = indexPath

    return cell
}
*/
