//
//  PersonalViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class PersonalViewController: UIViewController {
    
    
    @IBOutlet var userimage: UIImageView!
    
    @IBOutlet var settingtableview: UITableView!
    
    @IBOutlet var userdescLabel: UILabel!
    var viewModel = PersonalViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        Reload()
        settingtableview.delegate = self
        settingtableview.dataSource = self
        viewModel.PersonelInfo()
        
    }
    func Reload(){
        viewModel.onFetched = { [weak self] items in
            DispatchQueue.main.async {
                self?.settingtableview.reloadData()
            }
            
        }
        }
    
    

}
extension PersonalViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.personelItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hucre = viewModel.personelItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "personelhucre", for: indexPath) as! PersonalTableViewCell
        cell.itemNameLabel.text = hucre
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) seçildi")
    }
    
    
    
}
