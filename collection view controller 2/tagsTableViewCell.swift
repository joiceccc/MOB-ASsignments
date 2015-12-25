//
//  tagsTableViewCell.swift
//  collection view controller
//
//  Created by Joyce Cheung on 17/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit

class tagsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var namelabel: UILabel!
    @IBOutlet var postimage: UIImageView!
    @IBOutlet var image2: UIImageView!
  
    @IBOutlet var label: UILabel!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
