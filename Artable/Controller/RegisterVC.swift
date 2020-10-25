//
//  RegisterVC.swift
//  Artable
//
//  Created by Ata Etgi on 25.10.2020.
//

import UIKit
import Firebase


class RegisterVC: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordCheckImage: UIImageView!
    @IBOutlet weak var confirmPassCheckImage: UIImageView!
    
    let checkmark = UIImage(systemName: AppImages.Checkmark)?.withTintColor(AppColors.Green, renderingMode: .alwaysOriginal)
    let xmark = UIImage(systemName: AppImages.Xmark)?.withTintColor(AppColors.Red, renderingMode: .alwaysOriginal)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        passwordText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPasswordText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let passText = passwordText.text else {
            return
        }
        guard let confirmText = confirmPasswordText.text else {
            return
        }
        
        
        
        //if we have stared typing in the confirm pass text
        if textField == confirmPasswordText || confirmText.isNotEmpty {
            passwordCheckImage.isHidden = false
            confirmPassCheckImage.isHidden = false
        } else {
            if passText.isEmpty || confirmText.isEmpty {
                passwordCheckImage.isHidden = true
                confirmPassCheckImage.isHidden = true
            }
        }
        
        //make it so when the passwords match, the checkmarks turn green.
        
            if passwordText.text == confirmPasswordText.text  {
                passwordCheckImage.image = checkmark
                confirmPassCheckImage.image = checkmark
            } else {
                passwordCheckImage.image = xmark
                confirmPassCheckImage.image = xmark
            }
        
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        
        
        guard let email = emailText.text, email.isNotEmpty,
              let username = usernameText.text, username.isNotEmpty,
              let password = passwordText.text, password.isNotEmpty else { return }
        
        
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                debugPrint(error)
                self.activityIndicator.stopAnimating()
                return
            }
            
            self.activityIndicator.stopAnimating()
            print("successfully registered new user.")
            
            
        }
        
        
        
    }
}
