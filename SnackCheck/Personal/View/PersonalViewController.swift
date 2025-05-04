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
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var viewModel:PersonalViewModel!
    var firestoreManager = FirestoreManager()

    override func viewDidLoad() {
        super.viewDidLoad()

       
        settingtableview.delegate = self
        settingtableview.dataSource = self
        viewModel = PersonalViewModel(firetoreManager: firestoreManager)
        Reload()
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
        let selectedCell = viewModel.personelItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "personelCell", for: indexPath) as! PersonalTableViewCell
        cell.itemNameLabel.text = selectedCell.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) seçildi")
    }
    
    
    
}
