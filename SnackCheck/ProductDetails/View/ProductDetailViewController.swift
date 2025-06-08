//
//  ProductDetailViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 12.04.2025.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    
    //MARK: -Properties
    
    @IBOutlet weak var enerjiLabel: UILabel!
    @IBOutlet var productBrand: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var saturatedFatLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var saltLabel: UILabel!
    @IBOutlet weak var fiberLabel: UILabel!
    @IBOutlet weak var carboLabel: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet weak var ButtonName: UILabel!
    @IBOutlet var contentTF: UITextView!
    @IBOutlet weak var stackViewContent: UIStackView!
    @IBOutlet weak var stackViewFoodTitle: UIStackView!
    @IBOutlet weak var stackViewFoodValue: UIStackView!
    @IBOutlet weak var stackviewAllpage: UIStackView!
    
   var viewModel = ProductDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let Product = viewModel.product {
            productBrand.text = Product.product_brand
            productName.text = Product.product_name
            configure()
            
            
        }
        ButtonName.text = viewModel.buttonName
        contentTF.text = viewModel.context
        
    }
    
    
    func configure(){
        
        guard let product = viewModel.product else { return }
       let foodValues = viewModel.configure(with: product)
        enerjiLabel.text = foodValues.enerji
        sugarLabel.text = foodValues.şekerler
        saltLabel.text = foodValues.tuz
        fiberLabel.text = foodValues.lif
        proteinLabel.text = foodValues.protein
        fatLabel.text = foodValues.yağ
        saturatedFatLabel.text = foodValues.doymuşYağ
        carboLabel.text = foodValues.karbonhidrat
        
        
    }


}
