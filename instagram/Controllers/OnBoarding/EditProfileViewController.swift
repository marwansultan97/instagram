//
//  EditProfileViewController.swift
//  instagram
//
//  Created by Marwan Osama on 9/26/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicture.layer.borderWidth = 0.5
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.black.cgColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        
    }


    @IBAction func saveImageDone(_ sender: UIBarButtonItem) {
        
        
    }

    @IBAction func changeProfilePictureBTN(_ sender: UIButton) {
    }
    
}
