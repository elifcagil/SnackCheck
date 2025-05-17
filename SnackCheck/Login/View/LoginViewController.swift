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
    
    var viewModel:LoginViewModel!
    var firestoreManager = FirestoreManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(firestoreManager: firestoreManager)
        

    }
    
 
    
    @IBAction func loginButton(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
        
        
        if button.titleLabel?.text == "GİRİŞ YAP" {
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
        if button.titleLabel?.text == "Kayıt Ol" {
            guard let email = userEmailTf.text, !email.isEmpty,let name = userNameTf.text , !name.isEmpty, let surname = userSurnameTf.text, !surname.isEmpty ,let password = userpasswordtf.text,!password.isEmpty  else {return}
            viewModel.register(name: name, surname: surname, email: email, password: password){ result in
                switch result{
                case.success():
                    print("kullanıcı oluşturuldu")
                    DispatchQueue.main.async { [weak self] in
                        self?.goToLogin()
                    }
                    
                case.failure(let error):
                    print("hata oluştu-\(error.localizedDescription)")
                }
            }
            

        }
        
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        signUpStackView.isHidden = false
        createAccountStackView.isHidden = true
        logINButton.setTitle("Kayıt Ol", for: .normal)
        loginLabel.text = "Kayıt Ol"
    }
    
    func goToLogin() {
        UIView.transition(with: self.view, duration: 0.2, options: [.transitionCrossDissolve], animations: { [weak self] in
            self?.signUpStackView.isHidden = true
            self?.createAccountStackView.isHidden = false
            self?.loginLabel.text = "Giriş Yap"
            self?.logINButton.setTitle("GİRİŞ YAP", for: .normal)
        }, completion: nil)
    }


}
