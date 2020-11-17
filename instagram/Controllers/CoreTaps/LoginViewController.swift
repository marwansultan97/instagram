//
//  LoginViewController.swift
//  instagram
//
//  Created by Marwan Osama on 9/26/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissTextFields()
        errorLabel.text = ""
        userNameText.layer.borderWidth = 1.0
        passwordText.layer.borderWidth = 1.0
    }
    
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        let error = validateFieldsLogin()
        if error != nil {
            showError(message: error!)
        }else {
            
            AuthManager.shared.loginUser(email: userNameText.text!, password: passwordText.text!) { (result,err) in
                if err != nil {
                    self.showError(message: "invalid username or password")
                }else {
                    let homeVC: UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "homeVC"))!
                    self.present(homeVC, animated: true)
                }
                
            }
            
        }
    }
    
    

    
    
    @IBAction func termsOfUse(_ sender: UIButton) {
        guard let url = URL(string: "https://help.instagram.com/581066165581870?%3F__hstc=259582869.99a265337744294b740e0787aea508c4.1580515200151.1580515200152.1580515200153.1&__hssc=259582869.1.1581292800142&__hsfp=1235564426&_ga=2.268372686.1304204721.1556549351-933118289.1529345498&helpref=page_content") else {return}
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
        
    }
    
    func validateFieldsLogin() -> String? {
        
        if userNameText.text == "" || passwordText.text == "" {
            return "Please Fill In Fields"
        }
        
        return nil
        
    }
    
    func showError(message: String) {
        errorLabel.text = message
        
    }
    
    func dismissTextFields()  {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    @objc func dismissKeyboard()  {
        
        view.endEditing(true)
        
    }
    
        
    
    
}
