//
//  ListTableViewCell.swift
//  instagram
//
//  Created by Marwan Osama on 10/6/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit


protocol FollowButtonDelegate {
    func didTapFollowButton(model: UserRelation)
}

enum FollowState {
    case following,notFollowing
}

struct UserRelation {
    let email: String
    let type: FollowState
}


class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var hasFollowedYou: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: FollowButtonDelegate?
    var model: UserRelation?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureCell(model: UserRelation) {
        self.model = model
        hasFollowedYou.text = model.email
        
        switch model.type {
        case.notFollowing:
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.blue, for: .normal)
        case.following:
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.red, for: .normal)
        }
        
        
    }
    
    
    @IBAction func followBtnTapped(_ sender: UIButton) {
        guard let model = model else {return}
        delegate?.didTapFollowButton(model: model)
    }
    
}
