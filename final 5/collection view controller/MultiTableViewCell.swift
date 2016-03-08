//
//  MultiTableViewCell.swift
//  collection view controller
//
//  Created by Joyce Cheung on 6/1/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import UIKit

class MultiTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet var collectionview: multicollectionview!

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
