//
//  ViewController2.swift
//  collection view controller
//
//  Created by Joyce Cheung on 4/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    var image = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        self.imageview.image = self.image
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var imageview: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
