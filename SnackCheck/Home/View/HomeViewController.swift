//
//  AnaSayfaViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.

//modelklasörü kullanmadan view ve viewmodel sınıflarını kullansam nasıl olur

// ana sayfadaki collection view a cell olarak urunlercell i bağlasam yani bir cell sınfıını iki tane farlı cell e versem olur mu

//butona tıklandığında o sayfadaki başlığa viewkontrollerdan erişmek istiyorum ama hata alıyprum


// scan özelliğini nasıl kullanıcam


import UIKit
import AVFoundation

class HomeViewController: UIViewController{
    
    @IBOutlet var Welcome: UILabel!
    
    @IBOutlet var allProductCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var barcodescanner : BarkodeScannerHelper!
    
    var isSearch = false
    
    
    
    var searchedProduct = [Product]()
    var searchedWord : String = ""
    
    var viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.showsBookmarkButton = true
        
        
        if let cameraImage = UIImage(systemName: "camera") { //sistemden çektiğimiz resmin doğru geldiğini kontrol ettik
            searchBar.setImage(cameraImage, for: .bookmark, state: .normal)
        }
        barcodescanner = BarkodeScannerHelper(ViewController: self)
        
        
        allProductCollectionView.delegate = self
        allProductCollectionView.dataSource = self
        
        SetUpUI()
        viewModel.FetchUrunler()
        
        viewModel.onFetched = { [weak self] products in
            DispatchQueue.main.async {
                self?.allProductCollectionView.reloadData()
            }
        }
    }
   

    
    func SetUpUI(){
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = allProductCollectionView.frame.size.width //bunu viewmodele taşımam gerekiyor ama collectionviewe nasıl erişeceğim bilemedim taşıyamadım ??
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let cellWidth = (width - 30)/2
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.3)
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 10
        
        allProductCollectionView.collectionViewLayout = design
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if isSearch {
            viewModel.aramaYap(searchedWord:searchedWord)
        }else{
            allProductCollectionView.reloadData()
        }
    }
}


extension HomeViewController : CollectionCellToViewControllerDelegate{
    func addFavorite(indexPath: IndexPath) {
        print(" helal be kız sana \(viewModel.productList[indexPath.item].product_name!) ürününü favorilere ekledin" )
    }
}



extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.productList[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        cell.productNameLabel.text = item.product_name
        cell.productBrandLabel.text = item.product_brand
        cell.productImage.image = UIImage(named: item.product_image!)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = viewModel.productList[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? ProductButtonDetailViewController {
            let viewModel = ProductButtonDetailViewModel()
            viewModel.product = selectedProduct
            detailVC.viewModel = viewModel
            navigationController?.pushViewController(detailVC, animated: true)
            
        }
    
        
        
        
        
        
        
    }
    
    
    
}



extension HomeViewController : UISearchBarDelegate {
    
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        barcodescanner?.startBarCodeScanner()
        print("bu uygulama kamera açmak istiyo sende istiyo musun gerçekten")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchview:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader,withReuseIdentifier: "searchbar", for: indexPath)
        return searchview
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedWord = searchText
        if searchedWord == "" {
            isSearch = false
            viewModel.FetchUrunler()
            
        }else{
            isSearch = true
            viewModel.aramaYap(searchedWord: searchedWord)
        }
        print("Arama Sonucu : \(searchedWord)")
       
       
    }
    
    
}


extension HomeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    
    class BarkodeScannerHelper {
        var ViewController : HomeViewController?
        var captureSession: AVCaptureSession?
        var previewLayer: AVCaptureVideoPreviewLayer?
        
        
        init(ViewController:HomeViewController){
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
