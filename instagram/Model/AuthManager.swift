//
//  AuthManager.swift
//  instagram
//
//  Created by Marwan Osama on 9/27/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

public class AuthManager {
    
    static let shared = AuthManager()
    

    public func registerNewUser(email: String, password: String,callback: @escaping (AuthDataResult?,Error?) -> Void) {
        
        // create account
        Auth.auth().createUser(withEmail: email, password: password, completion: callback)
        
        
        
    }
    
    public func loginUser(email: String, password: String,callback: @escaping (AuthDataResult?,Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: callback)
        
        
    }
    
    public func logout(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch  {
            print("failed loging out")
            completion(false)
        }

    }
    
    
    
    
    
}

