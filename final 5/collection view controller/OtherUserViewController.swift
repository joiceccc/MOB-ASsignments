//
//  ViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 4/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse
import MapKit

class OtherUserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource , UITableViewDelegate {

    var user : PFObject = PFObject(className: "")
    
    @IBOutlet var map: MKMapView!
    @IBOutlet var from: UILabel!
   
    var stars : Bool = false
    
    var following : Bool = false

    var reviewphotoappear : Bool = false

    @IBOutlet var adress: UILabel!
    @IBOutlet var namelabel: UILabel!
    
    var name : [String] = []
    var propic : [UIImage] = []
    var photos : [Photo] = []
    var reviews : [Review] = []
    var commentsarray : [PFObject] = []
    var indexpath = 0
    
    
    var username = ""
    var totalstars = 0
    var average = 0
    
    let filter = CIFilter(name: "CICircleSplashDistortion")
    let context = CIContext(options: nil)
    var extent: CGRect!
    var scaleFactor: CGFloat!
    
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var bio: UILabel!
    
    @IBOutlet var contact: UIButton!
    
    @IBOutlet var appearname: UILabel!
    @IBOutlet var collectionview: UICollectionView!
    
    @IBOutlet var scollview: UIScrollView!
    
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
   
//    @IBAction func rate(sender: AnyObject) {
//        if let currentuser = PFUser.currentUser() {
//            
//            var text = textbox.text
//            
//            var comments = PFObject(className: "Comments")
//            
//            comments["comments"] =  text! + "-" + currentuser.username!
//            
//            comments["commentfrom"] = PFUser.currentUser()
//            comments["commentto"] = user
//            // comments["rate star"] =
//            comments.saveInBackground()
//        var currentvalue = Int(slider.value)
//       
//            
//            
//            
//        comments["stars"] = currentvalue
//        self.collectionview.reloadData()
//  
//        
//        
//        }
//        
//    }
//
   
    
    @IBOutlet var ratestars: UIImageView!
    
    
    
    
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
        
        if segue.identifier == "user" {
            let destinationOptional = segue.destinationViewController as?
                WriteAReviewViewController
            if let destination = destinationOptional {
                destination.touser = user
            }
            
            
            
        }
        
        if segue.identifier == "showimage" {
                    let indexpaths = self.collectionview.indexPathsForSelectedItems()!
                        let indexpath = indexpaths[0] as NSIndexPath
            
                        let vc = segue.destinationViewController as! ViewController2
            
                    vc.image = self.photos[indexpath.row].image
                    vc.caption = self.photos[indexpath.row].caption
                    vc.photos = self.photos
                    vc.indexpath = indexpath.row
                    vc.user = user
            
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
        loadcomments()
        
    }
  
//    @IBOutlet var messagetextbox: UITextField!
    
    
    @IBOutlet var profilepic: UIImageView!
    
    override func viewDidLoad() {
        scollview.contentSize.height = 1450
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                collectionview.dataSource = self
        collectionview.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        
     photos = []
     //   loadphoto()
        
    
               namelabel.text = String( user["username"])
        
        from.text = String (user["from"])
        
        bio.text = String ( user["bio"] )
        adress.text = String (user["address"])
        appearname.text = String(user["appearname"])
        
        if let image = user["profileimages"] as? PFFile {
            image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                if error == nil {
                    if let imagedata = imagedata{
                        let image = UIImage(data: imagedata)
                        self.profilepic.image = image!
                        
                        self.profilepic.layer.borderWidth = 0.1
                        self.profilepic.layer.masksToBounds = false
                        self.profilepic.layer.borderColor = UIColor.blackColor().CGColor
                        self.profilepic.layer.cornerRadius = self.profilepic.frame.height/2
                        self.profilepic.clipsToBounds = true
                    
                    }
                }
            })
        }
        if let useraddress = user["location"] as? PFGeoPoint {
            print("GEOOOOOOOOOO")
            print (useraddress)
            var long = useraddress.longitude
            var lat = useraddress.latitude
       
            let location = CLLocationCoordinate2D(
                latitude: lat,
                longitude: long
            )
            // 2
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            map.setRegion(region, animated: true)
            
            //3
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            //annotation.title = "Big Ben"
            //annotation.subtitle = "London"
            map.addAnnotation(annotation)
        
            
           
            
            
            
        }
        
        
//        var message = PFObject(className: "Message")
//        
//        message["text"] = "hello"
//        
//        message["sender"] = PFUser.currentUser()
//        message["recepiant"] = user
//        
//        message.saveInBackground()
        
        self.navigationController!.navigationBar.topItem!.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        checkfollow()
        
       
  
    
    }
    
    
    
    
    
    func loadphoto (){
        photos = []
       
        if reviewphotoappear == false {
        
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
        
                    // 1
        
        
        
        
        } else if reviewphotoappear == true {
        
        
            let query = PFQuery(className: "ReviewPhoto")
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
            
            // 1
            
            

            
            
            
            
            
            
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
    
    

       func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell = tableview.dequeueReusableCellWithIdentifier("reuse", forIndexPath: indexPath) as! CommentsTableViewCell
       
        cell.label.text = reviews[indexPath.row].review
       cell.stars.image = UIImage(named: String(reviews[indexPath.row].stars) + ".png")
        cell.name.text = reviews[indexPath.row].commentfrom
        cell.propic.image = reviews[indexPath.row].proimage
        
        
        cell.propic.layer.borderWidth = 0.1
        cell.propic.layer.masksToBounds = false
        cell.propic.layer.borderColor = UIColor.blackColor().CGColor
        cell.propic.layer.cornerRadius = cell.propic.frame.height/2
        cell.propic.clipsToBounds = true
        
        
        
        //  cell.imageView?.image = UIImage(named: (commentsarray[indexPath.row]["stars"] as? String)!)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return commentsarray.count }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func loadcomments (){
        var  comments = []
        
       reviews = []
        
        if let currentuser = PFUser.currentUser() {
            
            var commentstouser = PFQuery(className: "Comments")
            // messagetouser.whereKey("recepiant", equalTo: currentuser)
            commentstouser.whereKey("commentto", equalTo: user)
            
            commentstouser.includeKey("commentfrom")
            
            
            
            
            
            commentstouser.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                
                
                if let objects = objects {
                    
                    print("object count: \(objects.count)")
                    
                    self.commentsarray = objects
                    
                   
                    
                    print(self.commentsarray)
                     self.tableview.reloadData()
                    
                    print("stars")
              //  print(self.commentsarray[1]["stars"])
                
                    
                  
                    
                    var counter = 0
                    
                    while counter < objects.count {
                        
                        let review = Review()
                        let object = objects[counter]
                    
                    self.totalstars =  self.totalstars + (self.commentsarray[counter]["stars"] as! Int)
                     
                    print(self.commentsarray[counter]["commentfrom"])
                      
                        if let comments = self.commentsarray[counter]["comments"] as? String {
                            review.review = comments
                        }
                   
                        if let star = self.commentsarray[counter]["stars"] as? Int {
                            review.stars = star
                        }
                        
                        
                        if let user = self.commentsarray[counter]["commentfrom"]
                            as? PFObject {
                                print("HELLOlocation ")
                                print( user["appearname"] )
                                print( user["location"])
                                print( user["bio"])
                                
                                if let image = user["profileimages"] as? PFFile {
                                    image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                                        if error == nil {
                                            if let imagedata = imagedata{
                                                let image = UIImage(data: imagedata)
                                                
                                                
                                                review.proimage = image!
                                                self.tableview.reloadData()
                                            }
                                        }
                                    })
                                }

                        
                                if let name = user["appearname"] as? String {
                                    review.commentfrom = name                                }
                                
                                self.reviews.append(review)
                               self.tableview.reloadData()
                        }
                        
                        counter++
                    }
                     print("counter")
                    print(counter)
                    
                    
                    print("total stars")
                    
                  print(self.totalstars)
                    
                    print("average")
                 // relook this     print( self.totalstars / counter)
                    
                    print("reviewwwssss")
                    print(self.reviews.count)
                    
                  // relook this  self.average = self.totalstars / counter
                    
                    if self.average == 1 {
                        
                        self.starimage.image = UIImage(named: "1.png")
                       // self.numberofstars.text = "1"
                    }
                    else if self.average == 2 {
                        
                   self.starimage.image = UIImage(named: "2.png")
                  // self.numberofstars.text = "2"
                    }
                    else if self.average == 3 {
                        
                        self.starimage.image = UIImage(named: "3.png")
                   //self.numberofstars.text = "3"
                    }
                    else if self.average == 4 {
                        self.starimage.image = UIImage(named: "4.png")
                       // self.numberofstars.text = "4"
                        
                    }
                    else if self.average == 5 {
                        self.starimage.image = UIImage(named: "5.png")
                       // self.numberofstars.text = "5"
                        
                    }
                    
                     self.numberofstars.text = "(" + String(counter) + ")"
                    
                   // let users = PFObject(className: "")
                    // PFUser = user
                    
                   self.user as! PFUser
                    
                    self.user["average"] = self.average
                    self.user["counter"] = counter
                    
                   self.user.saveInBackground()
                    
                }
                
                print(self.commentsarray.count)
                print(self.reviews.count)
                print("COUNTS")
                
                
            })
            
            
            
            
        }
        
        
        
       
    }
    
    @IBAction func reviewphotos(sender: AnyObject) {
         reviewphotoappear = true
  
        loadphoto()
        
        
        collectionview.reloadData()
    
    }

    
    
    @IBAction func postphotos(sender: AnyObject) {
        reviewphotoappear = false
        loadphoto()
    }
    
    @IBOutlet var notice: UILabel!
       @IBOutlet var reviewphotos: UIButton!
    @IBOutlet var starimage: UIImageView!

    @IBOutlet var numberofstars: UILabel!
    
    @IBAction func writereview(sender: AnyObject) {
     self.performSegueWithIdentifier("user", sender: self)
    
    }
    @IBOutlet var follow: UIButton!
   
    @IBAction func follow(sender: AnyObject) {
        
        if let currentuser = PFUser.currentUser() {
            
           var followfuc = PFObject(className: "Follow")
            
            followfuc["follower"] = PFUser.currentUser()
            
            
            
            followfuc["followingto"] = ["__type": "Pointer", "className": "_User", "objectId": user.objectId!]
            
            
            followfuc.saveInBackgroundWithBlock({ (success, error) -> Void in
                print("followingfuc saved")
                print(success)
                print(error)
                self.follow.setTitle("FOLLOWING", forState: .Normal)
               self.follow.backgroundColor = UIColor(red: 0.3, green: 0.75, blue: 0.3, alpha: 0.8)
            })
            
            
            follow.setTitle("FOLLOWING", forState: .Normal)
           // var message = PFObject(className: "Message")
        }
    }
    
    func checkfollow (){
    
        if let currentuser = PFUser.currentUser() {
            
            var followerquery = PFQuery(className: "Follow")
            
            followerquery.whereKey("follower", equalTo: currentuser)
            followerquery.whereKey("followingto", equalTo: user)
            
             //var followeringquery = PFQuery(className: "Follow")
            
            //followeringquery.whereKey("followingto", equalTo: user)
            
           // var query = PFQuery.orQueryWithSubqueries([followeringquery,followerquery])
            
            followerquery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if let objects = objects {
                var counter = 0
                    while counter < objects.count {
                        
                        let object = objects[counter]
                    
                        print("yessssss followed")
                       
                        print(counter)
                        self.follow.setTitle("FOLLOWING", forState: .Normal)
                        self.follow.backgroundColor = UIColor(red: 0.3, green: 0.75, blue: 0.3, alpha: 0.8)

                       
                    counter++
                    }; if (counter == 0) {  self.following = false }
                    
                    }
                
            })
        
        }
       
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

