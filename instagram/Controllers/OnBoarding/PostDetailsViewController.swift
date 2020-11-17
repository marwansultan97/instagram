//
//  PostDetailsViewController.swift
//  instagram
//
//  Created by Marwan Osama on 9/26/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit
import SDWebImage

class PostDetailsViewController: UIViewController{
    

    var post: UserPost?
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var numberOfLikes: UIButton!
    

    
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.type.rawValue
        profilePicture.layer.borderWidth = 0.5
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.black.cgColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        profilePicture.sd_setImage(with: post?.owner.profilePicture, completed: nil)
        
        userName.text = post?.owner.userName
        captionLabel.text = post?.caption
        numberOfLikes.setTitle("Liked By \(post?.likesCount.count ?? 0)", for: .normal)
        
        postImage.sd_setImage(with: post?.thumbnailImage, completed: nil)

        
        
    }
    

    @IBAction func likeButtonTapped(_ sender: UIButton) {
        if likeButton.imageView?.image == UIImage(named: "heartBW") {
            likeButton.setImage(UIImage(named: "heartRED"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "heartBW"), for: .normal)
        }
        
        
    }
    
    
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "PostDetailsToComment", sender: self)
    }
    

    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostDetailsToComment" {
            let destinationVC = segue.destination as! CommentViewController
            destinationVC.post = post
        }
        
    }
    
}
