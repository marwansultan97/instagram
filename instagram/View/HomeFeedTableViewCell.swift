//
//  HomeFeedTableViewCell.swift
//  instagram
//
//  Created by Marwan Osama on 10/10/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

protocol HomeFeedTableViewCellDelegate: AnyObject {
    func didTapLikeButton(post: UserPost)
    func didTapCommentButton(post: UserPost)
    func didTapShareButton(post: UserPost)
    func didTapMoreButton(post: UserPost)
}


class HomeFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var postPhoto: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var numberOfLikes: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    var player: AVPlayer?
    var playerLayer = AVPlayerLayer()
    
    var delegate: HomeFeedTableViewCellDelegate?
    var post: UserPost?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicture.layer.borderWidth = 0.5
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.black.cgColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        contentView.layer.addSublayer(playerLayer)
        contentView.layoutSubviews()
        // to mute and unmute Videos
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mute)))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        profilePicture.image = nil
        captionLabel.text = nil
        userName.text = nil
        numberOfLikes.text = nil
        postPhoto.image = nil
        playerLayer.player = nil
    }
    
    
    override func layoutSubviews() {
        playerLayer.frame = postPhoto.frame
    }
    
    func configureCell(post: UserPost) {
        self.post = post
        let profilePictureURL = post.owner.profilePicture
        profilePicture.sd_setImage(with: profilePictureURL, completed: nil)
        userName.text = post.owner.userName
        numberOfLikes.text = "Liked By \(post.likesCount.count)"
        captionLabel.text = post.owner.userName + " : " + post.caption!
        
        switch post.type {
        case.photo:
            postPhoto.sd_setImage(with: post.thumbnailImage, completed: nil)
        case.video:
            let player = AVPlayer(url: post.postUrl)
            playerLayer.player = player
            playerLayer.player?.isMuted = true
            playerLayer.player?.play()
            playerLayer.player?.actionAtItemEnd = .none
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: playerLayer.player?.currentItem)
            
                
            }
        
        
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
        }
    }
    
    @objc func mute() {
        if playerLayer.player!.isMuted {
            playerLayer.player?.isMuted = false
            
        } else {
            playerLayer.player?.isMuted = true
        }
        
    }
    
    
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        guard let post = post else {return}
        delegate?.didTapMoreButton(post: post)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        guard let post = post else {return}
        delegate?.didTapLikeButton(post: post)
    }
    
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        guard let post = post else {return}
        delegate?.didTapCommentButton(post: post)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let post = post else {return}
        delegate?.didTapShareButton(post: post)
    }
    
}

