//
//  ViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 11.03.2025.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var kategorilertableview: UITableView!
    
    
    var kategorilerListe = [category]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       

        
        let k1 = category(category_id: "1", category_name: "Sağlıklı Yaşam")
        let k2 = category(category_id: "2", category_name: "İçecekler")
        let k3 = category(category_id: "3", category_name: "Meyve-Sebze")
        let k4 = category(category_id: "4", category_name: "Atıştırmalıklar")
        
        kategorilerListe.append(k1)
        kategorilerListe.append(k2)
        kategorilerListe.append(k3)
        kategorilerListe.append(k4)

        kategorilertableview.delegate = self
        kategorilertableview.dataSource = self

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
//    func TumKategorileriAl(){
//        AF.request("http://127.0.0.1:8000/api/categories/",method: .get).response{
//            response in
//            
//            
//            print("HTTP Durumu: \(response.response?.statusCode ?? -1)")
//                   
//                   if response.error != nil {
//                       print("Hata: \(response.error!.localizedDescription)")
//                   } else {
//                       print("Veri alındı.")
//                   }
//            if let data = response.data{
//                do{
//                    let cevap = try JSONDecoder().decode(categoryCevap.self, from: data)
//                    if let gelencategoriler = cevap.category{
//                        self.kategorilerListe = gelencategoriler
//                        print("Veriler başarıyla alındı: \(self.kategorilerListe)")
//
//                    }
//                        DispatchQueue.main.async {
//                        self.kategorilertableview.reloadData()
//                    }
//                    
//                }catch{
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }


}
extension ViewController : UITableViewDelegate ,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategorilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kategori = kategorilerListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategorilercell",for: indexPath) as! KategorilerTableViewCell
        cell.kategoriAdiLabel.text = kategori.category_name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "kategoritourunler", sender: indexPath.row)
    }
    
    
    
    
    
    
}

