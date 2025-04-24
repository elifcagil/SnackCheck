//
//  UrunDetayViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import UIKit

struct UrunDetailModel{
    var brand :String
    var name: String
    var image: String //viewmodele gidicek
}
class ButonDetailViewController: UIViewController {
    
    var urun: Product?
    var viewModel  = ProductViewModel()
    var indexPath: IndexPath?
    
    @IBOutlet var urunbrandlabel: UILabel!
    
    @IBOutlet var urunnamelabel: UILabel!
    
    
    @IBOutlet var urunimageview: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urun = urun{
            urunbrandlabel.text = urun.product_brand
            urunnamelabel.text = urun.product_name
            urunimageview.image = UIImage(named: urun.product_image!)
        }
        
    }
    var selectedUrun : Product?
    
    @IBAction func urunicerigibutton(_ sender: Any) {
        performSegue(withIdentifier: "urunicerigi", sender: urun)
        
    }
    
    @IBAction func urunanalizbutton(_ sender: Any) {
        performSegue(withIdentifier: "analiz", sender: urun)
        
        
    }
    @IBAction func urunalerjenbutton(_ sender: Any) {
        performSegue(withIdentifier: "alerjen", sender: urun)
        
    }
    @IBAction func urunbesindegerbutton(_ sender: Any) {
        performSegue(withIdentifier: "besindegeri", sender: urun)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let urun = sender as? Product
        let gidilecekVC = segue.destination as! ProductDetailViewController
       
        
        switch segue.identifier {
        case "urunicerigi":
                
                gidilecekVC.butonAdiName = "İçindekiler"  //direkt labele neden erişemiyorum?
                gidilecekVC.Urun = urun
            gidilecekVC.context = urun?.ingeridents
                
        case "analiz" :
                gidilecekVC.butonAdiName = "Ürün Analizi"
                gidilecekVC.Urun = urun
                gidilecekVC.context = "Gemini AI dan gelicek burası"
            
        case "alerjen" :
                gidilecekVC.butonAdiName = "Alerjen Uyarısı"
                gidilecekVC.Urun = urun
                gidilecekVC.context = "Gemini AI dan gelecek"
            
        case "besindegeri" :
                gidilecekVC.butonAdiName = "Besin Değerleri"
                gidilecekVC.Urun = urun
            gidilecekVC.context = urun?.food_values
            
            
        default:
            break
            }
        }
        
        
        
    }
    
    

