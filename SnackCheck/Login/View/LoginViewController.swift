//
//  LoginViewController.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 17.03.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var signUpStackView: UIStackView!
    
    @IBOutlet weak var userNameTf: UITextField!
    
    @IBOutlet weak var userSurnameTf: UITextField!
    
    
    
    @IBOutlet var loginLabel: UILabel!
    
    @IBOutlet var userEmailTf: UITextField!
    
    @IBOutlet var userpasswordtf: UITextField!
    
    @IBOutlet weak var logINButton: UIButton!
    
    @IBOutlet weak var createAccountStackView: UIStackView!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
        if button.titleLabel?.text == "Giriş Yap" {
            login()
            
        }
        if button.titleLabel?.text == "Kayıt Ol" {
            register()
            self.dismiss(animated: true, completion: nil)

            
            
        }
        
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        signUpStackView.isHidden = false
        createAccountStackView.isHidden = true
        logINButton.setTitle("Kayıt Ol", for: .normal)
        loginLabel.text = "Kayıt Ol"
    }
    
    
    
    
    
    
    
    
    func login(){
        print("logine tıkladı")
    }
    func register(){
        print("register olmak istiyor")
    }

}
