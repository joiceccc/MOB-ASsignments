//
//  File.swift
//  collection view controller
//
//  Created by Joyce Cheung on 15/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class Photo {
    var image = UIImage ()
    var caption = ""
    var byuser = ""
    var userimage = UIImage()
   // var usernamepfobjects = PFObject()
    var user = PFObject(className: "")
    var images = [UIImage].self
}