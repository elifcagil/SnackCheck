//
//  AnaSayfaViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit
import AVFoundation

class AnaSayfaViewController: UIViewController{
    
    @IBOutlet var HosgeldinLabel: UILabel!
    
    @IBOutlet var tumuruncollectionview: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    var barcodescanner : BarkodeScannerHelper!
    var aramaYapılıyorMu = false
    var urunlerListe = [Urunler]()
    var arananUrunler = [Urunler]()
    var aramaKelimesi : String = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.showsBookmarkButton = true
        if let cameraImage = UIImage(systemName: "camera") { //sistemden çektiğimiz resmin doğru geldiğini kontrol ettik
            searchBar.setImage(cameraImage, for: .bookmark, state: .normal)
        }
        barcodescanner = BarkodeScannerHelper(ViewController: self)
        
        tumuruncollectionview.delegate = self
        tumuruncollectionview.dataSource = self



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

        let tasarim : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = tumuruncollectionview.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let hucregenislik = (genislik - 30)/2
        tasarim.itemSize = CGSize(width: hucregenislik, height: hucregenislik*1.3)
        tasarim.minimumLineSpacing = 10
        tasarim.minimumInteritemSpacing = 10
        
        tumuruncollectionview.collectionViewLayout = tasarim

    }
    override func viewWillAppear(_ animated: Bool) {
        if aramaYapılıyorMu {
            aramaYap(aramaKelimesi:aramaKelimesi)
        }else{
            
            tumuruncollectionview.reloadData()
        }
    }
    
    func aramaYap(aramaKelimesi:String){
        
        arananUrunler = urunlerListe.filter{
            $0.urun_name?.lowercased().contains(aramaKelimesi.lowercased()) ?? false
            
        }
        urunlerListe = arananUrunler
    
    }
}

extension AnaSayfaViewController : CollectionCellToViewControllerDelegate{
    func favorilereEkle(indexPath: IndexPath) {
        print(" helal be kız sana \(urunlerListe[indexPath.item].urun_name!) ürününü favorilere ekledin" )
    }
    

}











extension AnaSayfaViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urunlerListe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = urunlerListe[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "anasayfacell", for: indexPath) as! AnaSayfaCollectionViewCell
        cell.urunNameLabel.text = item.urun_name
        cell.urunBrandLabel.text = item.urun_brand
        cell.urunimage.image = UIImage(named: item.urun_resim!)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item a tıklandı")
    }
    
    
    
}



extension AnaSayfaViewController : UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        barcodescanner?.startBarCodeScanner()
        print("bu uygulama kamera açmak istiyo sende istiyo musun gerçekten")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchview:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader,withReuseIdentifier: "searchbar", for: indexPath)
        return searchview
    }
    
    
    
    
    
    
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        aramaKelimesi = searchText
        if aramaKelimesi == "" {
            aramaYapılıyorMu = false
            
        }else{
            aramaYapılıyorMu = true
            aramaYap(aramaKelimesi: aramaKelimesi)
        }
        tumuruncollectionview.reloadData()
        print("Arama Sonucu : \(aramaKelimesi)")
       
       
    }
    
    
}



























extension AnaSayfaViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    
    class BarkodeScannerHelper {
        var ViewController : AnaSayfaViewController?
        var captureSession: AVCaptureSession?
        var previewLayer: AVCaptureVideoPreviewLayer?
        
        
        init(ViewController:AnaSayfaViewController){
            self.ViewController = ViewController
        }
        
        func startBarCodeScanner() {
            captureSession = AVCaptureSession()
            
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput
            
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }
            if captureSession?.canAddInput(videoInput) == true {
                captureSession?.addInput(videoInput)
            }
            else{
                return
                
            }
            let metadataOutput = AVCaptureMetadataOutput()
            
            if captureSession?.canAddOutput(metadataOutput) == true {
                captureSession?.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(ViewController, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .qr]
            }
            else{
                return
            }
            
            guard let view = ViewController?.view else { return }
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            previewLayer?.frame = view.layer.bounds
            previewLayer?.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer!)
            captureSession?.startRunning()
            
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first{
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let barcode = readableObject.stringValue else { return }
            barcodescanner?.captureSession?.stopRunning()
            DispatchQueue.main.async {
                self.searchBar.text = barcode
                self.barcodescanner?.previewLayer?.removeFromSuperlayer()
            }
            
            
        }
    }
    
}
