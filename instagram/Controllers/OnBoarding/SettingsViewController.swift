//
//  SettingsViewController.swift
//  instagram
//
//  Created by Marwan Osama on 9/26/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit
import SafariServices

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()

    }
    

    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 60.0
    }

    
    // MARK: - TableView Methods
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsCell.allCases.count
    }
    
    
    // cell Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.textLabel?.text = SettingsCell(rawValue: indexPath.row)?.description
        return cell
    }
    
    // did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            logOut()
        } else if indexPath.row == 1 {
            showTermsOfUse()
        } else if indexPath.row == 2 {
            helpOrFeedback()
        } else if indexPath.row == 3 {
            editProfileTapped()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func logOut() {
        let alert: UIAlertController = UIAlertController.init(title: "Logout", message: "are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Cancle", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction.init(title: "Logout", style: .destructive, handler: { _ in
            AuthManager.shared.logout { (success) in
                if success {
                    let loginVC: UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "loginVC"))!
                    self.present(loginVC, animated: true)
                }
            }
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func showTermsOfUse() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870?%3F__hstc=259582869.99a265337744294b740e0787aea508c4.1580515200151.1580515200152.1580515200153.1&__hssc=259582869.1.1581292800142&__hsfp=1235564426&_ga=2.268372686.1304204721.1556549351-933118289.1529345498&helpref=page_content") else {return}
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func helpOrFeedback() {
        guard let url = URL(string: "https://help.instagram.com/") else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func editProfileTapped() {
        let vc: UIViewController = (storyboard?.instantiateViewController(withIdentifier: "editProfileVC"))!
        navigationController?.pushViewController(vc, animated: true)
        
        

        
    }
    
    
    
}
