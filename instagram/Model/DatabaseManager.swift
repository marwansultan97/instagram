//
//  DatabaseManager.swift
//  instagram
//
//  Created by Marwan Osama on 9/26/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.



import Foundation
import FirebaseAuth
import FirebaseFirestore

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    public func checkEmailAvailable(email: String, callback: @escaping (FIRQuerySnapshotBlock)) {
        
        let db = Firestore.firestore()
        let docRef = db.collection("emails").whereField("email", isEqualTo: email).limit(to: 1)
        docRef.getDocuments(completion: callback)

 
        
    }
    
    
    public func saveEmailDatabase(email: String) {
        
        let db = Firestore.firestore()
        db.collection("emails").addDocument(data: ["email": email]) { (err) in
            if err != nil {
                print("error saving email in database \(String(describing: err))")
            }
        }
        
    }
    
    
    
}

