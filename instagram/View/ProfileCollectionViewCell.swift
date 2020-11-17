//
//  ProfileCollectionViewCell.swift
//  instagram
//
//  Created by Marwan Osama on 10/6/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    
    
    func configure(post: UserPost) {
        postImage.sd_setImage(with: post.thumbnailImage, completed: nil)
    }
    
    
}
