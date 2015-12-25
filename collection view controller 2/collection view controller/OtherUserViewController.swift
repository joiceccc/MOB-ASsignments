//
//  ViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 4/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class OtherUserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var user : PFObject = PFObject(className: "")
    
    @IBOutlet var from: UILabel!
    
    @IBOutlet var namelabel: UILabel!
    
    var photos : [Photo] = []
    
    
    @IBOutlet var contact: UIButton!
    
    @IBOutlet var collectionview: UICollectionView!
    
    
    let alpha = ["A", "b", "c", "d"]
    
    let imageArray = [UIImage(named: "poster1.jpg"), UIImage(named: "poster2.jpg"), UIImage(named: "poster 3.jpg"), UIImage(named: "poster4.jpg")]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("rows")
        return self.photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.imageviw.image = self.photos[indexPath.row].image
        cell.label.text = self.photos[indexPath.row].caption
        return cell
    }
   
    
    
    
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showimage", sender: self)
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showimage" {
//        let indexpaths = self.collectionview.indexPathsForSelectedItems()!
//            let indexpath = indexpaths[0] as NSIndexPath
//            
//            let vc = segue.destinationViewController as! ViewController2
//    
//        vc.image = self.imageArray[indexpath.row]!
//            vc.title = self.alpha[indexpath.row]
//        }
//    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sendmessage" {
            let destinationOptional = segue.destinationViewController as? MessageToUsersViewController
            if let destination = destinationOptional {
                destination.touser = user
            }
        }
    }
    
    @IBAction func inbox(sender: AnyObject) {
        
//        var text = messagetextbox.text
//        
//        var message = PFObject(className: "Message")
//        
//        message["text"] = text
//        
//        message["sender"] = PFUser.currentUser()
//        message["recepiant"] = user
//        
//        message.saveInBackground()
        
    }
    override func viewDidAppear(animated: Bool) {
        photos = []
        loadphoto()
    }
  
//    @IBOutlet var messagetextbox: UITextField!
    
    
    @IBOutlet var profilepic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionview.dataSource = self
        collectionview.delegate = self
    
        
     photos = []
     //   loadphoto()
            
       namelabel.text = String( user["username"])
        
        from.text = String (user["from"])
        
        
        if let image = user["profileimages"] as? PFFile {
            image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                if error == nil {
                    if let imagedata = imagedata{
                        let image = UIImage(data: imagedata)
                        self.profilepic.image = image!
                    }
                }
            })
        }
        
        
//        var message = PFObject(className: "Message")
//        
//        message["text"] = "hello"
//        
//        message["sender"] = PFUser.currentUser()
//        message["recepiant"] = user
//        
//        message.saveInBackground()
        
        
            
    }
    
    func loadphoto (){
        photos = []
        let query = PFQuery(className: "Photo")
        query.whereKey("belongsto", equalTo: user)
    query.findObjectsInBackgroundWithBlock { (objects, error ) -> Void in
        
        if let objects = objects {
            
            var counter = 0
            
            while counter < objects.count{
                print(counter)
                let photo = Photo()
                let object = objects[counter]
                
                if let caption = object["caption"] as? String {
                    photo.caption = caption
                }
                
                self.photos.append(photo)
                if let image = object["images"] as? PFFile {
                    image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                        if error == nil {
                            if let imagedata = imagedata{
                                let image = UIImage(data:imagedata)
                                photo.image = image!
                                self.collectionview.reloadData()
                            }
                        }
                    })
                }
             counter++
            }
            }
        }
        
        
        
        }
    
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        
//        let destinationOptional = segue.destinationViewController as? MessageToUsersViewController
//        if let destination = destinationOptional {
//            let indexPath = self.messagetableview.indexPathForSelectedRow
//            if let indexPath = indexPath {
//                
//                destination.user = users[indexPath.row]
//            }
//        }
//        
//    }
    




    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

