//
//  ProfileViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 15/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource{

    @IBOutlet var profilepic: UIImageView!
    
    @IBOutlet var collectionview: UICollectionView!
    
    @IBOutlet var whereyoufrom: UILabel!
    
    @IBOutlet var bio: UILabel!
    @IBOutlet var username: UILabel!
    @IBAction func logout(sender: AnyObject) {
        
        
        
        PFUser.logOut()
       // navigationController?.popViewControllerAnimated(true)
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    let alpha = ["A", "b", "c", "d"]
    
    let imageArray = [UIImage(named: "poster1.jpg"), UIImage(named: "poster2.jpg"), UIImage(named: "poster 3.jpg"), UIImage(named: "poster4.jpg")]
    
// var photos:[PFObject] = []
    var photos : [Photo] = []
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("rows")
        return self.photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCellWithReuseIdentifier("showimages", forIndexPath: indexPath) as! ProfileCollectionViewCell
        
        
        cell.images.image = self.photos[indexPath.row].image
        cell.captionLabel.text = self.photos[indexPath.row].caption
        
        return cell
    }

    override func viewDidAppear(animated: Bool) {
        //load photos again
      photos = []
        loadphotos()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos = []
//        loadphotos()
        
        if let currentuser = PFUser.currentUser(){
            
            if let image = currentuser["profileimages"] as? PFFile {
                image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                    if error == nil {
                        if let imagedata = imagedata {
                            let image = UIImage(data: imagedata)
                           self.profilepic.image = image!
                            
                        }
                    }
                })
            }
            

          
            
            
        }
        
        
        // Do any additional setup after loading the view.
    }
        func loadphotos () {
        
        if let currentuser = PFUser.currentUser() {
            print("current")
            print(currentuser.username)
            
            username.text = currentuser.username
    
            
            whereyoufrom.text = String( currentuser["from"] )
            bio.text = String( currentuser["bio"])
      //function
            
            photos = []
            
            let query = PFQuery(className: "Photo")
            
            query.whereKey("belongsto", equalTo: currentuser)
//            query.whereKey("caption", containsString: "caption")
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if let objects = objects {
  //                  self.photos = objects
                    
                    
                  var counter = 0
                    
                    while counter < objects.count {
                    
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
                                    if let imagedata = imagedata {
                                        let image = UIImage(data: imagedata)
                                        photo.image = image!
                                        
                                        self.collectionview.reloadData()
                                    }
                                }
                            })
                        }
                        
//                        let image = PFFile()
                        
//                        
//                        image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
//                            if error == nil {
//                                if let imagedata = imagedata {
//                                    let image = UIImage(data: imagedata)
//                                }
//                            }
//                        })
//                        
                        
                        counter++
                        
                    
                    }
                    
//                    let userimage 
                        
                    
                    
                 
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                self.collectionview.reloadData()
            })
            
            
//            let photo = PFObject(className: "Photo")
//            photo["caption"] = "gvgjb"
//            photo["belongsto"] = currentuser
//            
//            
//            photo.saveInBackground()
            
            
            
            
            
            
            
        }

    
    
        
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
