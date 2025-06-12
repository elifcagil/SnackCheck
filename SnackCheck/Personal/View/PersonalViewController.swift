//
//  PersonalViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class PersonalViewController: UIViewController {
    
    //MARK: -Properties
    @IBOutlet var userimage: UIImageView!
    @IBOutlet var settingtableview: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    var viewModel:PersonalViewModel!
    var firestoreManager = FirestoreManager()
    var userManager = UserManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = PersonalViewModel(firetoreManager: firestoreManager,userManager: userManager)
        Reload()
        viewModel.PersonelInfo()
        delegateMethod()
       
        
    }
    
    //MARK: HelperMethods
    
    func Reload(){
        viewModel.onFetched = { [weak self] items in
            DispatchQueue.main.async {
                self?.settingtableview.reloadData()
        }
    }
        viewModel.currenUserInfo { [weak self] result in
            switch result{
            case .success(let user):
                DispatchQueue.main.async {
                    self?.userNameLabel.text = "Merhaba \(user.name) \(user.surname)!"
                }
            case .failure(let error):
                print("kullanıcı bulunamadı \(error.localizedDescription)")
                
            }
            
            
        }
    }

    private func delegateMethod(){
        settingtableview.delegate = self
        settingtableview.dataSource = self
    }
    
    func deleteUser(email:String,password:String){
        viewModel.deleteUser(email: email,password: password) { result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                                if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                                    loginVC.modalPresentationStyle = .fullScreen
                                    self.present(loginVC, animated: true, completion: nil)
                                }
                            }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logOutUser(){
        viewModel.logOutUser { result in
            switch result{
            case .success():
                DispatchQueue.main.async {
                    if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}


//MARK: -TableViewDelegate

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
        let selectedItem = viewModel.personelItems[indexPath.row]
        
        
        if selectedItem.name == "Hesabımı Kalıcı Olarak Sil"{
            showAlert(){ email, password in
                self.deleteUser(email: email, password: password)
                
            }
            
            
        }
        if selectedItem.name == "Oturumu Kapat" {
            logOutUser()
        }
    }
    
    func goToMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
            
        }
    
    func showAlert(completion: @escaping (_ email: String, _ password: String) -> Void) {
        let alertController = UIAlertController(title:"Hesabınızı silmek için doğrulayın",message:"E-posta ve şifre bilgilerinizi girin",preferredStyle: .alert)
        alertController.addTextField{ mailTextfield in
            mailTextfield.placeholder =  "Email"
            mailTextfield.keyboardType = .emailAddress
            mailTextfield.autocapitalizationType = .none
        }
        alertController.addTextField{ passTextField in
            passTextField.placeholder = "Şifre"
            passTextField.isSecureTextEntry = true
        }
        let cancel = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Tamam", style: .default) { _ in
            guard let email = alertController.textFields?[0].text,!email.isEmpty,
                  let password = alertController.textFields?[1].text,!password.isEmpty else { return}
            completion(email,password)
            
        }
        alertController.addAction(cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
        }
}
