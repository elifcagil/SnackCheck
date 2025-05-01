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
        let product = sender as? Product
        let togoVC = segue.destination as! ProductDetailViewController
        togoVC.product = product
       
        
        switch segue.identifier {
        case "ingeridents":
                
            togoVC.buttonName = "İçindekiler" 
            togoVC.context = product?.ingeridents
                
        case "analize" :
            togoVC.buttonName = "Ürün Analizi"
            togoVC.context = "Gemini AI dan gelicek burası"
            
        case "alergen" :
            togoVC.buttonName = "Alerjen Uyarısı"
            togoVC.context = "Gemini AI dan gelecek"
            
        case "foodValue" :
            togoVC.buttonName = "Besin Değerleri"
            togoVC.context = product?.food_values
            
            
        default:
            break
            }
        }
        
        
        
    }
    
    

