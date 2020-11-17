    //
//  CommentTableViewCell.swift
//  instagram
//
//  Created by Marwan Osama on 10/15/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureCell(post: UserPost , indexpath: Int)  {
        let userName = post.comments[indexpath].userName
        let text = post.comments[indexpath].text
        commentLabel.text = userName + " : " + text
    }

}
