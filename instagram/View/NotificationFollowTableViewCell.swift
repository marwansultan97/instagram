//
//  NotificationFollowTableViewCell.swift
//  instagram
//
//  Created by Marwan Osama on 10/8/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit

protocol NotificationFollowTableViewCellDelegate {
    func followBtn(model: UserNotification)
}


class NotificationFollowTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var hasFollowedYou: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    
    var delegate: NotificationFollowTableViewCellDelegate?
    
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
        followButton.layer.cornerRadius = 10
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.blue.cgColor
        switch model.type {
        case .follow(state: .notFollowing):
            followButton.setTitle("Follow Back", for: .normal)
        case.follow(state: .following):
            followButton.setTitle("Unfollow", for: .normal)
        case.like(_):
            break
        }
        hasFollowedYou.text = model.text + " followed you"
        profilePicture.sd_setImage(with: model.user.profilePicture, completed: nil)
        
    }
    

    @IBAction func followBtnTapped(_ sender: UIButton) {
        guard let model = model else {return}
        delegate?.followBtn(model: model)
    }
}
