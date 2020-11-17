//
//  ProfileViewController.swift
//  instagram
//
//  Created by Marwan Osama on 10/2/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit
import FirebaseAuth

private let reuseIdentifier = "profileCollectionViewCell"

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var FollowingButtonTitle: UIButton!
    @IBOutlet weak var followerButtonTitle: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var postsCount: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userPosts = [UserPost]()
    
    var seguePost: UserPost?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingPosts()
        bioLabel.text = "Sultan Is Here"
        collectionView.delegate = self
        collectionView.dataSource = self
        profilePicture.layer.borderWidth = 0.5
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.black.cgColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = Auth.auth().currentUser?.email
        
    }
    
    func fetchingPosts() {
        
        let user = User(userName: "Joe", bio: "", gender: .male, counts: UserCount(followers: 1, followings: 1, posts: 1), birthDate: Date(), profilePicture: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png")!)
        
        let user1 = User(userName: "Carla", bio: "", gender: .female, counts: UserCount(followers: 1, followings: 1, posts: 2), birthDate: Date(), profilePicture: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/girl.png")!)
        
        let user2 = User(userName: "Max", bio: "", gender: .male, counts: UserCount(followers: 1, followings: 1, posts: 2), birthDate: Date(), profilePicture: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/cat.png")!)
        
        
        let post = UserPost(identifier: "", type: .photo, thumbnailImage: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png")!, caption: "\(user.userName) : haha that's cool", likesCount: [PostLike(userName: "nobody", postIdentifier: "cool")], comments: [PostComment(identifier: "", userName: "Mohamed", text: "WOOOOOOOW thaaaaaaaaaaaat waaaaaaaaaaaaas soooooooooooooo goooooooooood aaaaaaaaaaaand peeeeeeeerfeeeeeeeeeeeeeect hahahahahahahahahahahahaha", date: Date(), likes: [CommentLike(userName: "marwan", commentIdentifier: "")]),PostComment(identifier: "", userName: "Mohamed", text: "WOOOOOOOW", date: Date(), likes: [CommentLike(userName: "marwan", commentIdentifier: "")])], postUrl: URL(string: "https://www.google.com")!, date: Date(), taggedUser: [], owner: user)
        
        let post1 = UserPost(identifier: "", type: .photo, thumbnailImage: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/fruits.png")!, caption: "\(user1.userName) : Delecious", likesCount: [PostLike(userName: "nobody", postIdentifier: "cool")], comments: [PostComment(identifier: "", userName: "Mohamed", text: "Cool", date: Date(), likes: [CommentLike(userName: "marwan", commentIdentifier: "")])], postUrl: URL(string: "https://www.google.com")!, date: Date(), taggedUser: [], owner: user1)
        
        let post2 = UserPost(identifier: "", type: .photo, thumbnailImage: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/watch.png")!, caption: "\(user2.userName) : Nice Watch", likesCount: [PostLike(userName: "nobody", postIdentifier: "cool")], comments: [], postUrl: URL(string: "https://www.google.com")!, date: Date(), taggedUser: [], owner: user2)
        
        userPosts.append(post)
        userPosts.append(post1)
        userPosts.append(post2)
        
        
    }
    
    
    // MARK: UICollectionViewDataSource

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCollectionViewCell
        let post = userPosts[indexPath.row]
        cell.configure(post: post)

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = userPosts[indexPath.row]
        self.seguePost = post
        performSegue(withIdentifier: "ProfileToPostDetails", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.collectionView.frame.width/3.2) + 1 , height: (self.collectionView.frame.width/3.2) + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ListOfFollowers" {
            let destinationVC = segue.destination as! ListViewController
            var data = [UserRelation]()
            data.append(UserRelation(email: "BOBO", type: .following))
            data.append(UserRelation(email: "KOKO", type: .notFollowing))
            destinationVC.data = data
        } else if segue.identifier == "ListOfFollowings" {
            let destinationVC = segue.destination as! ListViewController
            var data = [UserRelation]()
            data.append(UserRelation(email: "BEBE", type: .following))
            data.append(UserRelation(email: "KEKE", type: .notFollowing))
            destinationVC.data = data
        } else if segue.identifier == "ProfileToPostDetails" {
            let destinationVC = segue.destination as! PostDetailsViewController
            destinationVC.post = seguePost
        }
    }
    

}
