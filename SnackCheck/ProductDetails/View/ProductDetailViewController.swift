//
//  ProductDetailViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 12.04.2025.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    
    @IBOutlet var productBrand: UILabel!
    
    
    @IBOutlet var productName: UILabel!
    
    
    @IBOutlet weak var ButtonName: UILabel!
    
    
    @IBOutlet var contentTF: UITextView!
    
   var viewModel = ProductDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let Product = viewModel.product {
            productBrand.text = Product.product_brand
            productName.text = Product.product_name
            
        }
        ButtonName.text = viewModel.buttonName
        contentTF.text = viewModel.context
        
    }
    


}
