//
//  FollowFeedViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 1/3/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class FollowFeedViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {

    
    var photos : [Photo] = []
    
    var followerlistappear : Bool = false
    
    @IBOutlet var follower: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos = []

        
        
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
       // loadfollowing()
        self.collectionview.reloadData()
        // Do any additional setup after loading the view.
    }
    @IBOutlet var collectionview: UICollectionView!

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FollowingFeedCollectionViewCell
        cell.image.image = self.photos[indexPath.row].userimage
        cell.label.text = self.photos[indexPath.row].caption
        cell.image.layer.borderWidth = 0.1
         cell.image.layer.masksToBounds = false
         cell.image.layer.borderColor = UIColor.blackColor().CGColor
         cell.image.layer.cornerRadius =  cell.image.frame.height/2
         cell.image.clipsToBounds = true
        return cell
    }
    override func viewDidAppear(animated: Bool) {
        loadfollowing()
        self.collectionview.reloadData()

    }
    
    func loadfollowing (){
        
        photos = []
        
        if followerlistappear == false {
        if let currentuser = PFUser.currentUser() {
            
                    var query = PFQuery(className: "Follow")
        
        query.whereKey("follower", equalTo: currentuser)
        query.includeKey("followingto")
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if let objects = objects {
                
                    var counter = 0
                    while counter < objects.count {
                    let photo = Photo()
                    
                    let object = objects[counter]
                    
                         self.photos.append(photo)
                        
                    if let user = object["followingto"]as? PFObject {
                        
                        print("FOOOOOWLOOOOING")
                        print(user["bio"])
                        
                        
                        print(counter)
                        if let image = user["profileimages"] as? PFFile {
                            image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                                if error == nil {
                                    if let imagedata = imagedata {
                                        let image = UIImage(data: imagedata)
                                        photo.userimage = image!
                                        self.collectionview.reloadData()
                                                                       }
                                }
                            })
                        }
                    
                        if let name = user["username"] as? String {
                            photo.caption = name
                        
                        }
                       print(photo.caption)
                        print(self.self.photos.count)
                       
                    }
                    
                            counter++
                    }
                 print(self.photos)
                }
                
            })
        
        
        
        }
    
        } else if followerlistappear == true {
        if let currentuser = PFUser.currentUser() {
            
            var query = PFQuery(className: "Follow")
            
            query.whereKey("followingto", equalTo: currentuser)
            query.includeKey("follower")
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if let objects = objects {
                    
                    var counter = 0
                    while counter < objects.count {
                        let photo = Photo()
                        
                        let object = objects[counter]
                        
                        self.photos.append(photo)
                        
                        if let user = object["follower"]as? PFObject {
                            
                            print("FOOOOOWLOOOOING")
                            print(user["bio"])
                            
                            
                            print(counter)
                            if let image = user["profileimages"] as? PFFile {
                                image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                                    if error == nil {
                                        if let imagedata = imagedata {
                                            let image = UIImage(data: imagedata)
                                            photo.userimage = image!
                                            self.collectionview.reloadData()
                                        }
                                    }
                                })
                            }
                            
                            if let name = user["username"] as? String {
                                photo.caption = name
                                
                            }
                            print(photo.caption)
                            print(self.self.photos.count)
                            
                        }
                        
                        counter++
                    }
                    print(self.photos)
                }
                
            })
            
            
            
            }
        
    }
    }
        
    @IBOutlet var following: UIButton!
    @IBAction func following(sender: AnyObject) {
       
        followerlistappear = false
        loadfollowing()
        collectionview.reloadData()

        
    }
    @IBAction func follower(sender: AnyObject) {
        followerlistappear = true
        
        loadfollowing()
        collectionview.reloadData()
        
        
    }
    override func didReceiveMemoryWarning() {
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
