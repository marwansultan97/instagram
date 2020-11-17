//
//  RegisterViewController.swift
//  instagram
//
//  Created by Marwan Osama on 9/26/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = ""
        dismissText()
        

    }

    @IBAction func signupTapped(_ sender: UIButton) {
        let error = validateFields()
        if error != nil {
            showError(message: error!)
        }else {
            errorLabel.text = ""
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (result, err) in
                if err != nil {
                    if (err! as NSError).code == AuthErrorCode.emailAlreadyInUse.rawValue{
                        self.showError(message: "Email Is Already Taken")
                    }
                } else {
                    
                    
                    
                }
            }
 
        }
        
        
    }
    
    
    func validateFields() -> String? {
        if firstNameText.text == "" || lastNameText.text == "" || emailText.text == "" || passwordText.text == "" {
            return "Please fill in all Fields"
        }
        
        if isWrongName(name: firstNameText.text!) {
            return "first name must be at least 4 characters"
        }
        if isWrongName(name: lastNameText.text!) {
            return "last name must be at least 4 characters"
        }
        if (emailText.text?.contains("."))! && (emailText.text?.contains("@"))! {
            return nil

        }
        if isValidPassword(password: passwordText.text!) == false {
            return "password must be at least 8 characters with 1 uppercase and 1 lowercase"
        } else {
            return "invalid email form"
        }
        
    }
    
    
    func showError(message: String)  {
        errorLabel.text = message
        
    }
    
    
    func dismissText() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func isWrongName(name: String) -> Bool {
        return name.count < 4
        
        
    }
    
    func isValidPassword(password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let validPassword = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return validPassword.evaluate(with: password)
        
    }
    
    
    
}
