//
//  ViewController.swift
//  instagram
//
//  Created by Marwan Osama on 9/26/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var postModels = [UserPost]()
    
    var seguePost: UserPost?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 600
        fetchingFeedPosts()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        checkAuthentication()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        configureTabbar()
    }
    
    
    private func checkAuthentication() {
        
        if Auth.auth().currentUser == nil {
            let loginVC: UIViewController = (storyboard?.instantiateViewController(withIdentifier: "loginVC"))!
            present(loginVC, animated: true, completion: nil)
        }
    }
    
    func fetchingFeedPosts() {
        
        let user = User(userName: "Sultan", bio: "Sultan is Here", gender: .male, counts: UserCount(followers: 1, followings: 1, posts: 1), birthDate: Date(), profilePicture: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/tulips.png")!)
        let post = UserPost(identifier: "", type: .video, thumbnailImage: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/peppers.png")!, caption: "cool", likesCount: [PostLike(userName: "", postIdentifier: "")], comments: [PostComment(identifier: "", userName: "Joe", text: "Nice Video", date: Date(), likes: []), PostComment(identifier: "", userName: "Max", text: "wow good job i reallalalalalalalalalalalalay don't belieeeeeeeeve how u dou taht lokokokoko", date: Date(), likes: [])], postUrl: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4")!, date: Date(), taggedUser: [], owner: user)
        
        let post1 = UserPost(identifier: "", type: .video, thumbnailImage: URL(string: "https://homepages.cae.wisc.edu/~ece533/images/peppers.png")!, caption: "cool", likesCount: [PostLike(userName: "", postIdentifier: "")], comments: [PostComment(identifier: "", userName: "marwan", text: "nice", date: Date(), likes: [])], postUrl: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!, date: Date(), taggedUser: [], owner: user)
        
        postModels.append(post)
        postModels.append(post1)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! HomeFeedTableViewCell
        let post = postModels[indexPath.row]
        cell.configureCell(post: post)
        cell.delegate = self
        return cell

}
    
    func configureTabbar() {
        guard let tabbar = self.tabBarController?.tabBar else {return}
        tabbar.barTintColor = .white
        tabbar.layer.borderWidth = 1
        tabbar.layer.borderColor = UIColor.black.cgColor
        tabbar.layer.cornerRadius = 30
        tabbar.layer.masksToBounds = true
        tabbar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let offset = scrollView.contentOffset.y
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        
        let alpha: CGFloat = 1 - scrollView.contentOffset.y*0.03
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(alpha)]
    }

}

extension HomeViewController: HomeFeedTableViewCellDelegate {
    
    func didTapLikeButton(post: UserPost) {
        
    }
    
    func didTapCommentButton(post: UserPost) {
        self.seguePost = post
        performSegue(withIdentifier: "HomeToComment", sender: self)
    }
    
    func didTapShareButton(post: UserPost) {
        
    }
    
    func didTapMoreButton(post: UserPost) {
        let alert = UIAlertController.init(title: "options", message: "", preferredStyle: .actionSheet)
        let cancleAction = UIAlertAction.init(title: "Cancle", style: .destructive, handler: nil)
        let reportAction = UIAlertAction.init(title: "Report", style: .default) {_ in
            self.reportPost()
        }
        alert.addAction(reportAction)
        alert.addAction(cancleAction)
        present(alert, animated: true)
    }
    
    func reportPost() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToComment" {
            let destinationVC = segue.destination as! CommentViewController
            destinationVC.post = seguePost
        }
    }
    
    
}
