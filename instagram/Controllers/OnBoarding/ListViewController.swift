//
//  ListViewController.swift
//  instagram
//
//  Created by Marwan Osama on 10/6/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
        var data: [UserRelation]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        
        if data == nil {
            cell.hasFollowedYou.text = "no Followers yet"
            cell.followButton.isHidden = true
            cell.profileImage.isHidden = true
        } else {
            cell.configureCell(model: data![indexPath.row])
            
        }
        cell.delegate = self
        return cell
    }

}

extension ListViewController: FollowButtonDelegate {
    func didTapFollowButton(model: UserRelation) {
        switch model.type {
        case.following:
            return
            // Update Fire Base to Follow this Acc
        case.notFollowing:
            return
            // Update Fire Base to Unfollow this Acc
        }
    }
    
    
    
    
}
