//
//  UrunDetayViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import UIKit




class ProductButtonDetailViewController: UIViewController {
    
    
    var viewModel: ProductButtonDetailViewModel!
    var indexPath: IndexPath?
    
    @IBOutlet var productbrandLabel: UILabel!
    
    @IBOutlet var productNameLabel: UILabel!
    
    
    @IBOutlet var prodcutImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let product = viewModel.product{
            productbrandLabel.text = product.product_brand
            productNameLabel.text = product.product_name
            prodcutImageView.image = UIImage(named: product.product_image!)
        }
        
        
    }
    
    
    @IBAction func ingeridentsButton(_ sender: Any) {
        performSegue(withIdentifier: "ingeridents", sender: viewModel.product)
        
    }
    
    @IBAction func analizeButton(_ sender: Any) {
        performSegue(withIdentifier: "analize", sender: viewModel.product)
        
        
    }
    @IBAction func allergenButton(_ sender: Any) {
        performSegue(withIdentifier: "alergen", sender: viewModel.product)
        
    }
    @IBAction func foodValuesButton(_ sender: Any) {
        performSegue(withIdentifier: "foodValue", sender: viewModel.product)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let product = sender as? Product{
            let togoVC = segue.destination as! ProductDetailViewController
            let ViewModel = ProductDetailViewModel()
            ViewModel.product = product
            togoVC.viewModel = ViewModel
            
            
            switch segue.identifier {
            case "ingeridents":
                
                ViewModel.buttonName = "İçindekiler"
                ViewModel.context = product.ingeridents
                
                
                
            case "analize" :
                ViewModel.buttonName = "Ürün Analizi"
                ViewModel.context = "Gemini AI dan gelicek burası"
                
                
            case "alergen" :
                ViewModel.buttonName = "Alerjen Uyarısı"
                ViewModel.context = "Gemini AI dan gelecek"
                
                
            case "foodValue" :
                ViewModel.buttonName = "Besin Değerleri"
                ViewModel.context = "\(product.product_name!) ürünün besin değerleri aşağıdaki gibidir."
                togoVC.loadViewIfNeeded() //daha diğer syafanın viewıv yüklenmediği için buradan erişitğimizden önce onun yüklenmesini sağlarız daha sonra stackview e erişim isteriz.
                togoVC.stackviewAllpage.isHidden = false
                
                
                
                
                
            default:
                break
            }
        }
        
        
        
    }
    
    
}
