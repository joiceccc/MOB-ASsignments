//
//  ViewController2.swift
//  collection view controller
//
//  Created by Joyce Cheung on 4/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class ViewController2: UIViewController , UIScrollViewDelegate{

    var image = UIImage()
    var caption = ""
    var photos : [Photo] = []
     var indexpath = 0
    var user : PFObject = PFObject(className: "")
    
    @IBOutlet var scoll: UIScrollView!
    @IBOutlet var captionlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        self.imageview.image = self.image
        self.captionlabel.text = self.caption
       // scoll.contentSize.height = 800
        
        
        print("indexxxxxxpathhhh")
        print(indexpath)
        
        print(photos)
        
        print(user)
        self.scoll.maximumZoomScale = 6
        self.scoll.minimumZoomScale = 1
        likes.imageView?.image = UIImage(named:"heart.png")
        
        name.text = String(user["appearname"])
        
        if let image = user["profileimages"] as? PFFile {
            image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                if error == nil {
                    if let imagedata = imagedata{
                        let image = UIImage(data: imagedata)
                        self.propic.image = image!
                        
                        self.propic.layer.borderWidth = 0.1
                        self.propic.layer.masksToBounds = false
                        self.propic.layer.borderColor = UIColor.blackColor().CGColor
                        self.propic.layer.cornerRadius = self.propic.frame.height/2
                        self.propic.clipsToBounds = true
                        
                    }
                }
            })
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func likes(sender: AnyObject) {
       //likes.imageView?.image = UIImage(named:"heart.png")
        likes.reloadInputViews()
        likes.setImage(UIImage(named: "liked.png"), forState: UIControlState.Normal)
        print (" likeeed")
    }
        @IBOutlet var likes: UIButton!
    
   
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageview
    }

   
    @IBAction func swipe(sender: AnyObject) {
        if indexpath < photos.count - 1  {
            indexpath =  indexpath + 1
            print(indexpath)
            print(photos.count)
            imageview.image = photos[indexpath].image
            likes.setImage(UIImage(named: "likes.png"), forState: UIControlState.Normal)
        } else { print ("END")
            
           
        }
    }
    
    @IBOutlet var propic: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swiperight(sender: AnyObject) {
        if   1 <= indexpath {
            indexpath =  indexpath - 1
            print(indexpath)
            self.imageview.image = photos[indexpath].image
            
             likes.setImage(UIImage(named: "likes.png"), forState: UIControlState.Normal)
            
        } else {print ("END")
           
        }
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
