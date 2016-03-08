//
//  tabbar.swift
//  collection view controller
//
//  Created by Joyce Cheung on 30/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import Foundation

class TabBar: UITabBar {
    override func intrinsicContentSize() -> CGSize {
        var intrinsicSize = super.frame.size
        
        intrinsicSize.height = 120
        return intrinsicSize
    }
}