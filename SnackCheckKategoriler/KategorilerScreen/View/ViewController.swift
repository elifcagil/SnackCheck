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
    var viewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kategorilertableview.delegate = self
        kategorilertableview.dataSource = self
        Reload()
        viewModel.FetchKategoriler()
    
    }
    
    func Reload(){
        viewModel.onItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.kategorilertableview.reloadData()
            }
        }
    }
}


extension ViewController : UITableViewDelegate ,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.kategorilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kategori = viewModel.kategorilerListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategorilercell",for: indexPath) as! KategorilerTableViewCell
        cell.kategoriAdiLabel.text = kategori.category_name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "kategoritourunler", sender: indexPath.row)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let gidilecekVC = segue.destination as! UrunlerViewController
        gidilecekVC.kategori = viewModel.kategorilerListe[index!]
    }
}

