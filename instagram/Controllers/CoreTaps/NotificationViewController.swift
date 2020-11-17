//
//  NotificationViewController.swift
//  instagram
//
//  Created by Marwan Osama on 9/26/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var models = [UserNotification]()
    
    var seguePost: UserPost?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //        tableView.isHidden = true
        tableView.rowHeight = 50
        spinner.hidesWhenStopped = true
        //        spinner.startAnimating()
        fetchNotifications()
        tableView.rowHeight = 60
    }
    
    func fetchNotifications() {
        
        let user = User(userName: "Joe", bio: "", gender: .male, counts: UserCount(followers: 1, followings: 1, posts: 1), birthDate: Date(), profilePicture: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png")!)
        
        let user1 = User(userName: "Carla", bio: "", gender: .female, counts: UserCount(followers: 1, followings: 1, posts: 2), birthDate: Date(), profilePicture: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/girl.png")!)
        
        let user2 = User(userName: "Max", bio: "", gender: .male, counts: UserCount(followers: 1, followings: 1, posts: 2), birthDate: Date(), profilePicture: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/cat.png")!)
        
        
        let post = UserPost(identifier: "", type: .photo, thumbnailImage: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png")!, caption: "\(user.userName) : haha that's cool", likesCount: [PostLike(userName: "nobody", postIdentifier: "cool")], comments: [], postUrl: URL(string: "https://www.google.com")!, date: Date(), taggedUser: [], owner: user)
        
        let post1 = UserPost(identifier: "", type: .photo, thumbnailImage: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/fruits.png")!, caption: "\(user1.userName) : Delecious", likesCount: [PostLike(userName: "nobody", postIdentifier: "cool")], comments: [PostComment(identifier: "", userName: "Mohamed", text: "Cool", date: Date(), likes: [CommentLike(userName: "marwan", commentIdentifier: "")])], postUrl: URL(string: "https://www.google.com")!, date: Date(), taggedUser: [], owner: user1)
        
        let post2 = UserPost(identifier: "", type: .photo, thumbnailImage: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/watch.png")!, caption: "\(user2.userName) : Nice Watch", likesCount: [PostLike(userName: "nobody", postIdentifier: "cool")], comments: [], postUrl: URL(string: "https://www.google.com")!, date: Date(), taggedUser: [], owner: user2)
        
        let model = UserNotification(type:.like(post: post), text: "anything", user: user)
        let model1 = UserNotification(type: .like(post: post1), text: "Hello", user: user1)
        let model2 = UserNotification(type: .like(post: post2), text: "Watchy", user: user2)
        
        
        models.append(model)
        models.append(model1)
        models.append(model2)
        tableView.reloadData()
        
        
        
        
    }
    
    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case.like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationLikeTableViewCell", for: indexPath) as! NotificationLikeTableViewCell
            cell.configureCell(model: model)
            cell.delegate = self
            
            return cell
        case.follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationFollowTableViewCell", for: indexPath) as! NotificationFollowTableViewCell
            cell.configureCell(model: model)
            
            cell.delegate = self
            return cell
        }
        
        
        
    }
    
}

extension NotificationViewController : NotificationLikeTableViewCellDelegate, NotificationFollowTableViewCellDelegate {
    func photoButton(model: UserNotification) {
        print("tapped Button")
        //Open Tapped Post
        switch model.type {
        case.follow(_):
            fatalError("Dev Issue: Shouldn't be called")
        case.like(let post):
            self.seguePost = post
            performSegue(withIdentifier: "notificationToPost", sender: self)
            
        }
    }
    
    
    func followBtn(model: UserNotification) {
        print("Follow or Unfollow")
        // Follow or unfollow
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PostDetailsViewController
        destinationVC.post = seguePost
    }
    
    
}
