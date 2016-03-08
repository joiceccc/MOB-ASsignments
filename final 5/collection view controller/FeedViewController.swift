//
//  FeedViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 3/3/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse


class FeedViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate{

     var photos : [Photo] = []
    
    var followingphotos : [Photo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.reloadData()

      self.collectionview.delegate = self
        self.collectionview.dataSource = self
      // loadfollowing()
        
        self.collectionview.reloadData()

        
        // Do any additional setup after loading the view.
    }

    @IBOutlet var collectionview: UICollectionView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followingphotos.count
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FeedCollectionViewCell
        cell.propic.image = self.followingphotos[indexPath.row].userimage
        cell.image.image = self.followingphotos[indexPath.row].image
        cell.caption.text = self.followingphotos[indexPath.row].caption
        cell.name.text = self.followingphotos[indexPath.row].byuser
        cell.propic.layer.borderWidth = 0.1
        cell.propic.layer.masksToBounds = false
        cell.propic.layer.borderColor = UIColor.blackColor().CGColor
        cell.propic.layer.cornerRadius = cell.propic.frame.height/2
        cell.propic.clipsToBounds = true
    return cell
    }
    
    func loadfollowing (){
    
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
                        
                        photo.user = user
                        
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
                        print(photo.user)
                        
                       
                    
                    
                    
                    
                    
                    }
                    
                    counter++
                }
                print(self.photos)
               
            }
             self.loadfollowingphoto()
            print(self.photos.count)
            print(self.followingphotos.count)
        })
        }
    
    
    
    }
    
    override func viewDidAppear(animated: Bool) {
        self.collectionview.reloadData()
        loadfollowing()
        

    }
    
   func loadfollowingphoto (){
    print("countingggggggg")
    print(photos.count)
    var counter1 = 0
    
    var users:[PFObject] = []
    
    while counter1 < photos.count {
        
        users.append(photos[counter1].user)
        
        counter1++
    }
    
    
    print("counter1")
    print(counter1)
    var query = PFQuery(className: "Photo")
    
    query.whereKey("belongsto", containedIn: users)
    query.includeKey("belongsto")
    query.addDescendingOrder("createdAt")
    
    query.limit = 100
    query.skip = 0
    
    query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
        if let objects = objects {
            
            var counter2 = 0
            while counter2 < objects.count {
                
                let followingphoto = Photo()
                print("counter2")
                print(counter2)
                let object = objects[counter2]
                
                self.followingphotos.append(followingphoto)
                
                if let image = object["images"] as? PFFile {
                    image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                        if error == nil {
                            if let imagedata = imagedata {
                                let image = UIImage(data: imagedata)
                                followingphoto.image = image!
                                self.collectionview.reloadData()
                            }
                        }
                    })
                }
                if let caption = object["caption"] as? String {
                    
                    followingphoto.caption = caption
                }
                if let user = object["belongsto"] as? PFObject {
                    
                    if let image = user["profileimages"] as? PFFile {
                        image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                            if error == nil {
                                if let imagedata = imagedata {
                                    let image = UIImage(data: imagedata)
                                    followingphoto.userimage = image!
                                    
                                    self.collectionview.reloadData()
                                }
                            }
                        })
                    }
                    if let name = user["appearname"] as? String {
                        
                        followingphoto.byuser = name
                    }
                    
                }
                
                counter2++
            }
            
            
        }
    })
    
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
