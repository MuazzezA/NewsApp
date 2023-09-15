//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 14.09.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var pswLogintextField: UITextField!
    @IBOutlet weak var mailLoginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonAct(_ sender: Any) {
        guard let email = mailLoginTextField.text, let password = pswLogintextField.text else {
                    // E-posta veya şifre eksikse hata işlemleri
            return
        }
                
                // Firebase Authentication ile giriş yap
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Giriş başarısız: \(error.localizedDescription)")
            } else {
                print("Giriş başarılı!")
                UserDefaults.standard.set(true, forKey: "isLogin")
                let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)

                // "Home.storyboard" içindeki istediğiniz view controller'ı alın (örneğin, ana view controller)
                let homeViewController = homeStoryboard.instantiateInitialViewController()

                // Kullanıcıyı "Home.storyboard" içindeki view controller'a yönlendirin
                UIApplication.shared.windows.first?.rootViewController = homeViewController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }
}
