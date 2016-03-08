//
//  SearchMessageTableViewCell.swift
//  collection view controller
//
//  Created by Joyce Cheung on 22/1/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import UIKit

class SearchMessageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var message: UILabel!
    @IBOutlet var user: UILabel!
    @IBOutlet var propic: UIImageView!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
