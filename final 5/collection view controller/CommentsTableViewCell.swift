//
//  CommentsTableViewCell.swift
//  collection view controller
//
//  Created by Joyce Cheung on 6/1/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var stars: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var propic: UIImageView!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
