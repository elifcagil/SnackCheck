//
//  LoginViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    
    
    @IBOutlet var loginLabel: UILabel!
    
    @IBOutlet var userEmailTf: UITextField!
    
    @IBOutlet var userpasswordtf: UITextField!
    
    @IBOutlet weak var logINButton: UIButton!
        
    @IBOutlet weak var createAccountButton: UIButton!
    
    var viewModel:LoginViewModel!
    var firestoreManager = FirestoreManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(firestoreManager: firestoreManager)
        

    }
    
 
    
    @IBAction func loginButton(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
            guard let email = userEmailTf.text,!email.isEmpty, let password = userpasswordtf.text,!password.isEmpty else {return}
            viewModel.login(email: email, password: password){ [weak self] result in
                DispatchQueue.main.async{
                    switch result {
                    case .success():
                        self?.performSegue(withIdentifier: "goToHome", sender:nil)
                    case.failure(let error):
                        print("giriş yapılamadı - \(error.localizedDescription)")
                    }
                }
                
            }
        
        
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
       
    }
    
  


}
