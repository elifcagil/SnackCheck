//
//  RegisterViewController.swift
//  SnackCheck
//
//  Created by ELİF ÇAĞIL on 7.06.2025.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var viewModel:RegisterViewModel!
    var firestoreManager = FirestoreManager()
    
    
    
    @IBOutlet weak var nameTf: UITextField!
    
    @IBOutlet weak var surnameTf: UITextField!
    
    @IBOutlet weak var emailTf: UITextField!
    
    @IBOutlet weak var passwordTf: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func loginButton(_ sender: Any) {
        goToMain()
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RegisterViewModel(firestoreManager: firestoreManager)
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerbutton(_ sender: Any) {
            guard let email = emailTf.text, !email.isEmpty,let name = nameTf.text , !name.isEmpty, let surname = surnameTf.text, !surname.isEmpty ,let password = passwordTf.text,!password.isEmpty  else {return}
            viewModel.register(name: name, surname: surname, email: email, password: password){ result in
                switch result{
                case.success():
                    print("kullanıcı oluşturuldu")
                    self.viewModel.login(email: email, password: password) { loginResult in
                        switch loginResult {
                        case .success():
                            self.performSegue(withIdentifier: "goToMain", sender:nil)
                            print("giriş başarılı")
                            
                        case .failure(let error):
                            print("hata \(error.localizedDescription)")
                        }
                    }
                    
                case.failure(let error):
                    print("hata oluştu-\(error.localizedDescription)")
                }
            }
            

        
    }
    func goToMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
            
        }
    
    
    

}
