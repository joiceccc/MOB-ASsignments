//
//  searchtagsViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 17/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse
import CoreLocation


class searchtagsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate,  UICollectionViewDataSource , UICollectionViewDelegate, CLLocationManagerDelegate {

     let locationmanager = CLLocationManager()
    
    
    var transfering = ""
    var lat :Double = 0
    var long : Double = 0
    
    var district = ""
    
    var destinationUser:PFObject = PFObject(className: "User")
    
    
    
    var photosDict: [PFObject:[Photo]] = [:]
    
    
    override func viewDidLoad() {
       
        tableview.dataSource = self
        tableview.delegate = self
        super.viewDidLoad()

        label.text = transfering
        self.locationmanager.delegate = self
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationmanager.requestWhenInUseAuthorization()
        self.locationmanager.startUpdatingLocation()
        loadphotos()
        
        loadtags()
      self.navigationController!.navigationBar.topItem!.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        
        // Do any additional setup after loading the view.
        
       
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        print("location update" )
        print(newLocation.coordinate)
        long = newLocation.coordinate.latitude
       lat =  newLocation.coordinate.longitude
    }
    
    
//    var photos : [Photo] = []

     var users : [PFObject] = []
    
    var user : [Userscoll] = []
   
    override func viewDidAppear(animated: Bool) {
        self.label.text = transfering

        
        print("district: \(district)")
    }
    
   
    @IBOutlet var tableview: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        if let currentuser = PFUser.currentUser() {
            
        
        }
        
        let cell = tableview.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! tagsTableViewCell
        cell.collectionview.delegate = self
        cell.collectionview.dataSource = self
     
    
       cell.collectionview.index = indexPath.row

        cell.collectionview.reloadData()
        
       // cell.textLabel?.text = photos[indexPath.row].caption
       //     cell.imageView?.image = photos[indexPath.row].image
        cell.label.text = users[indexPath.row]["bio"] as! String?
//        cell.postimage.image = photos[indexPath.row].image
        
        cell.namelabel.text = users[indexPath.row]["appearname"] as! String?
    //  cell.image2.image = user[indexPath.row].userimage
        cell.pricelabel.text = "$" + ( users[indexPath.row]["phighest"] as! String? )!
        
        cell.pricelabel2.text = "- $" + ( users[indexPath.row]["plowst"] as! String? )!

        let user = self.users[indexPath.row]

        if let photos = self.photosDict[user] {
            let photo = photos[0]
            cell.userpropic.image = photo.userimage
            cell.userpropic.layer.borderWidth = 0.1
            cell.userpropic.layer.masksToBounds = false
         cell.userpropic.layer.borderColor = UIColor.blackColor().CGColor
            cell.userpropic.layer.cornerRadius = cell.userpropic.frame.height/2
           cell.userpropic.clipsToBounds = true
            
        }

        return cell
        
        }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        destinationUser = self.users[indexPath.row]
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        
        performSegueWithIdentifier("toprofile", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let collectionView = collectionView as? multicollectionview {
            destinationUser = self.users[collectionView.index]
        }
        
        self.performSegueWithIdentifier("toprofile", sender: self)
    }
    
    @IBAction func map(sender: AnyObject) {
         self.performSegueWithIdentifier("map", sender: self)
    }
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var image: UIImageView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func loadphotos () {
        
//        if let currentuser = PFUser.currentUser() {
//            print("current")
//            print(currentuser.username)
//            
//            //user.text = currentuser.username
//            
//            
//            //user.text = String( currentuser["from"] )
//           
//            //function
  
            let userGeoPoint = PFGeoPoint(latitude: 22.28069085223984, longitude: 114.1584001947194)
       
       
        
        let userQuery = PFUser.query()!
      //  userQuery.whereKey("location", nearGeoPoint: userGeoPoint, withinKilometers: 0.1)
      //  userQuery.whereKey("location", nearGeoPoint:userGeoPoint)
 //   userQuery.whereKey("location", nearGeoPoint: userGeoPoint, withinRadians: 1)
        userQuery.whereKey("location", nearGeoPoint: userGeoPoint, withinMiles: 0.1)
        
        
     let querycap = PFQuery(className: "Photo")
        querycap.whereKey("caption", containsString: transfering)
        
        var querytags = PFQuery(className: "Photo")
      
       // var key = ["tags", "caption"]
        
        querytags.whereKey("belongsto", matchesQuery: userQuery)
        
     //  querytags.whereKey("belongsto", matchesQuery: querycap)
        
        querytags.whereKey("tags", containsString: transfering )
      
        querytags.includeKey("belongsto")
       
//      query.whereKey("tags", nearGeoPoint:userGeoPoint, withinKilometers: 100)
        
 // var query = PFQuery.orQueryWithSubqueries([querycap, querytags])

        
            querytags.findObjectsInBackgroundWithBlock  ({ (objects, error) -> Void in
              
                
                if let objects = objects {
                  //  self.photos = objects
                    var counter = 0
                    while counter < objects.count {
                    
                        
                        print(counter)
                        let photo = Photo()
                        
//                        let user = PFObject(className: "")
                        
                    let object = objects[counter]
                        
//                        self.photos.append(photo)
//                        self.users.append(user)
                        
                        
                        
                        
                        

//                        if let byusername =  object["belongstoname"] {
//                       self.users = byusername as! [PFObject]
//                                                     }
//                     
                       
                        
                        if let user = object["belongsto"]
                            as? PFObject {
                                print("HELLOlocation ")
                                print( user["location"])
                                photo.user = user
                                
                                
//                                var contains = false
//                                
//                                for u in self.users {
////                                    
////                                    print(user["username"])
////                                    print(u["username"])
//                                    if user.objectId == u.objectId {
//                                        contains = true
//                                    }
//                                }
                                
                                
                                if (!self.users.contains(user)) {
                                    self.users.append(user)
                                    self.photosDict[user] = []
                                }
                                
                                
                                self.photosDict[user]?.append(photo)
                               
                                if let image = user["profileimages"] as? PFFile {
                                    image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                                        if error == nil {
                                            if let imagedata = imagedata {
                                                let image = UIImage(data: imagedata)
                                                photo.userimage = image!
                                                
                                                self.tableview.reloadData()
                                            }
                                        }
                                    })
                                }
                    
//                             let querylocation = PFQuery(className: "User")
//                                
//                                 querylocation.whereKey("location", nearGeoPoint:userGeoPoint, withinKilometers: 100)
                        }

                       
                        
                        if let caption = object["caption"] as? String {
                            photo.caption = caption
                            print ("hello")
                          //   print(   self.photos[1].caption)
                            
                        }
                        if let belongstoname = object["belongstoname"] as? String {
                            photo.byuser = belongstoname
                            print ("hello")
                            //   print(   self.photos[1].caption)
                            
                        }
                       
                    
                        
                            if let image = object["images"] as? PFFile {
                                    image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                                                    if error == nil {
                                                        if let imagedata = imagedata {
                                                            let image = UIImage(data: imagedata)
                                                            photo.image = image!
                                                           
                                                            self.tableview.reloadData()
                                                        }
                }
                                })
                        }
                        
                                               
                        
//                       if  let pfOject:PFObject = object {
//                            if  let usersobject:PFUser = pfOject["belongsto"]as? PFUser {
//                                
//                             //   print( usersobject.objectId!)
//                                
//                                
//                                photo.byuser = usersobject.objectId!
//                              //  photo.byuser = usersobject.username!
//                               
//                            
//                                
//                               //  print( usersobject.username!)
//                            }
//                            
//                        }

                     
                        
                        
                        
                 counter++
                    
                }
                
                    
                    
                    
                }
            })
        
        
    
}
    
    
    
    
    
    
    @IBAction func filers(sender: AnyObject) {
   self.performSegueWithIdentifier("gofilters", sender: self)
    
    
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showsearch", sender: self)
        
    }
    
   
    
    @IBOutlet var heat: UIButton!
    @IBAction func heart(sender: AnyObject) {
        heat.imageView?.image = UIImage(contentsOfFile:"blank.png")
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if let destination = segue.destinationViewController as? OtherUserViewController {
           
                
            destination.user = destinationUser
         
         
        }
        
        if let destination = segue.destinationViewController as? FiltersViewController {
            destination.parentVC = self
        }
        if let destination = segue.destinationViewController as? MapViewController {
            destination.transfering = self.transfering
            destination.users = self.users
        }
        
        
        
    
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("numberOfItemsInSection")
        
        if let collectionview = collectionView as? multicollectionview {
            
            
            print("collection index " )
            print (collectionview.index)
            
            
            let user = self.users[collectionview.index]
            
            if let photos = self.photosDict[user] {
                return photos.count
            }
            
            
        }
        
        //        if (collectionView)
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell",  forIndexPath: indexPath) as! muiltiCollectionViewCell
        
        if let collectionview = collectionView as? multicollectionview {
            let user = self.users[collectionview.index]
            
            if let photos = self.photosDict[user] {
                let photo = photos[indexPath.row]
                cell.image.image = photo.image
            }
            
        }
        
        return cell
    }
    
    

    func loadtags () {
        
    
        
        let userGeoPoint = PFGeoPoint(latitude: 22.284681, longitude: 114.158177)
        
        
        
        let userQuery = PFUser.query()!
        //        userQuery.whereKey("location", nearGeoPoint:userGeoPoint)
        userQuery.whereKey("location", nearGeoPoint: userGeoPoint, withinKilometers: 1000)
        let querycap = PFQuery(className: "Photo")
        querycap.whereKey("caption", containsString: transfering)
        
        var querytags = PFQuery(className: "Photo")
        
        // var key = ["tags", "caption"]
        
        querytags.whereKey("belongsto", matchesQuery: userQuery)
        
        //  querytags.whereKey("belongsto", matchesQuery: querycap)
        
        querytags.whereKey("caption", containsString: transfering )
        
        querytags.includeKey("belongsto")
        
        //      query.whereKey("tags", nearGeoPoint:userGeoPoint, withinKilometers: 100)
        
        // var query = PFQuery.orQueryWithSubqueries([querycap, querytags])
        
        
        querytags.findObjectsInBackgroundWithBlock  ({ (objects, error) -> Void in
            
            
            if let objects = objects {
                //  self.photos = objects
                var counter = 0
                while counter < objects.count {
                    
                    
                    print(counter)
                    let photo = Photo()
                    
                    //                        let user = PFObject(className: "")
                    
                    let object = objects[counter]
                    
                    //                        self.photos.append(photo)
                    //                        self.users.append(user)
                    
                    
                    
                    
                    
                    
                    //                        if let byusername =  object["belongstoname"] {
                    //                       self.users = byusername as! [PFObject]
                    //                                                     }
                    //
                    
                    
                    if let user = object["belongsto"]
                        as? PFObject {
                            print("HELLOlocation ")
                            print( user["location"])
                            photo.user = user
                            
                            
                            //                                var contains = false
                            //
                            //                                for u in self.users {
                            ////
                            ////                                    print(user["username"])
                            ////                                    print(u["username"])
                            //                                    if user.objectId == u.objectId {
                            //                                        contains = true
                            //                                    }
                            //                                }
                            
                            
                            if (!self.users.contains(user)) {
                                self.users.append(user)
                                self.photosDict[user] = []
                            }
                            
                            
                            self.photosDict[user]?.append(photo)
                            
                            if let image = user["profileimages"] as? PFFile {
                                image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                                    if error == nil {
                                        if let imagedata = imagedata {
                                            let image = UIImage(data: imagedata)
                                            photo.userimage = image!
                                            
                                            self.tableview.reloadData()
                                        }
                                    }
                                })
                            }
                            
                            //                             let querylocation = PFQuery(className: "User")
                            //
                            //                                 querylocation.whereKey("location", nearGeoPoint:userGeoPoint, withinKilometers: 100)
                    }
                    
                    
                    
                    if let caption = object["caption"] as? String {
                        photo.caption = caption
                        print ("hello")
                        //   print(   self.photos[1].caption)
                        
                    }
                    if let belongstoname = object["belongstoname"] as? String {
                        photo.byuser = belongstoname
                        print ("hello")
                        //   print(   self.photos[1].caption)
                        
                    }
                    
                    
                    
                    if let image = object["images"] as? PFFile {
                        image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                            if error == nil {
                                if let imagedata = imagedata {
                                    let image = UIImage(data: imagedata)
                                    photo.image = image!
                                    
                                    self.tableview.reloadData()
                                }
                            }
                        })
                    }
                    
                    
                    
                    //                       if  let pfOject:PFObject = object {
                    //                            if  let usersobject:PFUser = pfOject["belongsto"]as? PFUser {
                    //
                    //                             //   print( usersobject.objectId!)
                    //
                    //
                    //                                photo.byuser = usersobject.objectId!
                    //                              //  photo.byuser = usersobject.username!
                    //
                    //
                    //
                    //                               //  print( usersobject.username!)
                    //                            }
                    //                            
                    //                        }
                    
                    
                    
                    
                    
                    counter++
                    
                }
                
                
                
                
            }
        })
        
        
        
    }
   
    
    @IBOutlet var map: UIButton!
    
}