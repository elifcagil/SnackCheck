//
//  UrunDetayViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import UIKit

class UrunDetayViewController: UIViewController {
    
    var urun: Urunler?
    var viewModel  = UrunlerViewModel()
    var indexPath: IndexPath?
    
    @IBOutlet var urunbrandlabel: UILabel!
    
    @IBOutlet var urunnamelabel: UILabel!
    
    
    @IBOutlet var urunimageview: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urun = urun{
            urunbrandlabel.text = urun.urun_brand
            urunnamelabel.text = urun.urun_name
            urunimageview.image = UIImage(named: urun.urun_resim!)
        }
        
    }
    var selectedUrun : Urunler?
    
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
        let urun = sender as? Urunler
        let gidilecekVC = segue.destination as! ProductDetailViewController
       
        
            if segue.identifier == "urunicerigi" {
                
                gidilecekVC.butonAdiName = "İçindekiler"  //direkt labele neden erişemiyorum?
                gidilecekVC.Urun = urun
                gidilecekVC.context = urun?.icindekiler
                
                
            }
            if segue.identifier == "analiz" {
                gidilecekVC.butonAdiName = "Ürün Analizi"
                gidilecekVC.Urun = urun
                gidilecekVC.context = "Gemini AI dan gelicek burası"
            }
            if segue.identifier == "alerjen" {
                gidilecekVC.butonAdiName = "Alerjen Uyarısı"
                gidilecekVC.Urun = urun
                gidilecekVC.context = "Gemini AI dan gelecek"
            }
            if segue.identifier == "besindegeri" {
                gidilecekVC.butonAdiName = "Besin Değerleri"
                gidilecekVC.Urun = urun
                gidilecekVC.context = urun?.besindegerleri
            }
        }
        
        
        
    }
    
    

