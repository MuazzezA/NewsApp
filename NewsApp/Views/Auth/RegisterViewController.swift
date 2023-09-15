//
//  RegisterViewController.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 14.09.2023.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

    @IBOutlet weak var mailRegisterTextField: UITextField!
    @IBOutlet weak var pswRegisterTextField: UITextField!
    
    var user = false {
        didSet {
            if(user){
                print("yönlendirme")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerButtonAct(_ sender: Any) {
        guard let email = mailRegisterTextField.text, let password = pswRegisterTextField.text else {
            // E-posta ve şifre alanlarının dolu olduğundan emin olun
            return
        }
            
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                
                print("Kullanıcı kaydı başarısız: \(error.localizedDescription)")
                if error.localizedDescription == "The email address is already in use by another account." {
                    let alertController = UIAlertController(title: "Hata", message: "Bu e-posta adresi zaten başka bir hesap tarafından kullanılıyor.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                self.user = false
            } else {

                let alertController = UIAlertController(title: "Başarılı", message: "Kayıt oldunuz! Artık giriş yapabilirsiniz.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Giriş Yap", style: .default) { (action) in
                    self.user = true
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)

            }
        }
    }
   
    
    
}
