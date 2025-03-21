//
//  UrunDetayViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import UIKit

class UrunDetayViewController: UIViewController {

    var urun:Urunler?
    
    @IBOutlet var urunbrandlabel: UILabel!
    
    @IBOutlet var urunnamelabel: UILabel!
    
    
    @IBOutlet var urunimageview: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let urun{
            urunbrandlabel.text = urun.urun_brand
            urunnamelabel.text = urun.urun_name
            urunimageview.image = UIImage(named: urun.urun_resim!)
        }
        
    }
    

    @IBAction func urunicerigibutton(_ sender: Any) {
        performSegue(withIdentifier: "icindekiler", sender: urun)
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
        if segue.identifier == "icindekiler"{
            let gidilecekVC = segue.destination as! İcindekilerViewController
            gidilecekVC.urun = urun
            
        }
        if segue.identifier == "analiz" {
            let gidilecekVC = segue.destination as! AnalizViewController
            gidilecekVC.urun = urun
            
        }
        if segue.identifier == "besindegeri"{
            let gidilecekVC = segue.destination as! BesinDegeriViewController
            gidilecekVC.urun = urun
            
        }
        if segue.identifier == "alerjen"{
            let gidilecekVC = segue.destination as! AlerjenViewController
            gidilecekVC.urun = urun
            
        }
        
    }
    
    
}
