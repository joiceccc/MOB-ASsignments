//
//  reviews.swift
//  collection view controller
//
//  Created by Joyce Cheung on 29/2/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import Foundation
import Parse

class Review {
    
    var proimage = UIImage ()
    var review = ""
    var commentfrom = ""
    var user = PFObject(className: "")
    var commentto = ""
    var stars = 0
    
}