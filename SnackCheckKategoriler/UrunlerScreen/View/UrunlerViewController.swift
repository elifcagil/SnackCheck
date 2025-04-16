//
//  UrunlerViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import UIKit

class UrunlerViewController: UIViewController {
    
    var viewModel = UrunlerViewModel()
    var kategori : category?

   
    @IBOutlet var searchbar: UISearchBar!
    
   
    
    @IBOutlet var urunlerCollectionView: UICollectionView!
    
    var arananurunler = [Urunler]()
    var favList = [Urunler]()
    var aramaYapılıyorMu = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        urunlerCollectionView.delegate = self
        urunlerCollectionView.dataSource = self
        
        searchbar.delegate = self
        
        title = kategori?.category_name
        
        SetUpUI()
        Reload()
        viewModel.FetchuUrunler()
       
    
        
    }
    func Reload(){
        viewModel.onItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.urunlerCollectionView.reloadData()
            }}
    }
    
  
   
    
    
    
    private func SetUpUI(){
        
        let tasarim : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.urunlerCollectionView.frame.size.width //collectionciewın genişliğini aldık
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right:10) //sağdan soldan yukardan aşapıdan 10 ar birim boşluk bıraktık
        let hucreGenislik = (genislik-30)/2 //oluşmasını istediğimiz hücrenin genisliğini bir değişkende tuttuk 10 ar birim boşluk bıraktığımız için eran genişliğinden 30 çıkardık ve bir satırda 2 tane olmasını istediğimiz için 2 ye böldük
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik*1.3)
        tasarim.minimumInteritemSpacing = 10 //yatayda hücreler arası istediğimiz boşluk
        tasarim.minimumLineSpacing = 10 //dikeyde hücreler arası boşluk
        
        urunlerCollectionView.collectionViewLayout = tasarim //collectionview a hazırladığımız tasarımı ekledik.
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let gidilecekVC = segue.destination as! UrunDetayViewController
        gidilecekVC.urun = viewModel.urunlerListe[index!]
        
    }
    
    
    
   
  

}
extension UrunlerViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.urunlerListe.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let urun = viewModel.urunlerListe[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "urunleritem", for: indexPath) as! UrunlerCollectionViewCell
        cell.urunbrand.text = urun.urun_brand
        cell.urunname.text = urun.urun_name
        cell.urunimage.image = UIImage(named: urun.urun_resim!)
        cell.layer.borderColor = UIColor.black.cgColor //collectionviewın çevresine çerçeve çizdik.
        cell.layer.borderWidth = 0.5 //çerçevenin kalınlığı

        cell.hucreProtocol = self //delegate bağlantısı
        cell.indexPath = indexPath
        
        
        
        return cell
        
        
        
        
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "urunlertodetay", sender: indexPath.row)
    }
    
    
    
}
    
extension UrunlerViewController:UrunHucreCollectionViewCellProtokol{ //collectionviewda tanımladığımız protokolü referans aldık.bu protokolden bize veri gelecek.indexpath verisi gelecek.
    func FavorilereEkle(indexPath: IndexPath) {
        print("helal be sana \(viewModel.urunlerListe[indexPath.item].urun_name!) favorilere ekledin sonunda")
        
    }
}

extension UrunlerViewController : UISearchBarDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchview:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader,withReuseIdentifier: "searchbar", for: indexPath)
        return searchview
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            aramaYapılıyorMu = false
            viewModel.FetchuUrunler()
        }else{
            aramaYapılıyorMu = true
            arananurunler = (viewModel.urunlerListe.filter { $0.urun_name?.lowercased().contains(searchText.lowercased()) ?? false})
            viewModel.urunlerListe = arananurunler
            
        }
        
        print("Arama sonucu:\(searchText)")
    }
}



    
    

