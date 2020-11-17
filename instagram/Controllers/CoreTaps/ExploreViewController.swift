//
//  ExploreViewController.swift
//  instagram
//
//  Created by Marwan Osama on 9/26/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    var userPosts = [UserPost]()
    
    let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        view.addSubview(transparentView)
    }
    override func viewDidLayoutSubviews() {
        transparentView.frame = collectionView.frame
    }
    
    
    
    // MARK: - CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
//        cell.configure(post: <#T##UserPost#>)
        cell.backgroundColor = .green
        return cell
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


}

extension ExploreViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Search in the DataBase
        
        UIView.animate(withDuration: 0.5) {
            self.transparentView.alpha = 0
        }
        searchBar.resignFirstResponder()
        
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            searchBar.resignFirstResponder()
            UIView.animate(withDuration: 0.5) {
                self.transparentView.alpha = 0
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        UIView.animate(withDuration: 0.5) {
            self.transparentView.alpha = 0
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.5) {
            self.transparentView.alpha = 0.4
        }
    }
    
    
}
