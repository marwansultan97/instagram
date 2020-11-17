//
//  NotificationLikeTableViewCell.swift
//  instagram
//
//  Created by Marwan Osama on 10/8/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit
import SDWebImage

protocol NotificationLikeTableViewCellDelegate {
    func photoButton(model: UserNotification)
}


class NotificationLikeTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var hasLikedPhoto: UILabel!
    @IBOutlet weak var photoButton: UIButton!
    
    
    var delegate: NotificationLikeTableViewCellDelegate?
    
    var model: UserNotification?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicture.layer.borderWidth = 0.5
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.black.cgColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    
    
    func configureCell(model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            photoButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
        case.follow:
            break
        }
        hasLikedPhoto.text = model.text + " liked your photo"
        profilePicture.sd_setImage(with: model.user.profilePicture, completed: nil)
        
    }

    @IBAction func photoButtonTapped(_ sender: UIButton) {
        guard let model = model else {return}
        delegate?.photoButton(model: model)
    }
}
