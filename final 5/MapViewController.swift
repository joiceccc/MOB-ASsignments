//
//  MapViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 22/2/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import UIKit
import MapKit
import Parse

class MapViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , MKMapViewDelegate {
 
    
    @IBOutlet var mapview: MKMapView!
    
    var transfering = ""
    var users : [PFObject] = []
        var photos : [Photo] = []
    var username = ""
    var shortdes = ""
    var phigh = ""
    var plow = ""
    var pic = UIImage()
    var pics = [UIImage()]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        self.mapview.delegate = self
        
        
        print ("transfering")
        print (transfering)
        
        print("users")
        print(users)
       print( users[1]["appearname"] as! String? )
       
        var counter = 0
        
        while counter < users.count {
        
        if let useraddress = users[counter]["location"] as? PFGeoPoint {
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
            mapview.setRegion(region, animated: true)
            
            //3
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = users[counter]["username"]as? String
           annotation.subtitle = users[counter]["bio"]as? String
           
            
            
//            var anView = mapview.dequeueReusableAnnotationViewWithIdentifier("reuseId") as? MKPinAnnotationView
//            if anView == nil {
//                anView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "reuseId")
//                anView!.canShowCallout = true
//                anView!.animatesDrop = true
//                anView!.pinColor = .Purple  // or Red or Green
//            }
//            else {
//                anView!.annotation = annotation
//            }
          
                        mapview.addAnnotation(annotation)
            counter++
            
            }
            
            
            
        }

     
        name.text = username
    
        mapview.reloadInputViews()
        profilepic.reloadInputViews()

//        loadphoto()
//        loadpropic()
        
        self.navigationController!.navigationBar.topItem!.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        // Do any additional setup after loading the view.
    }
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    
    print("selected annotation")
        let selectedLoc = view.annotation
        
        
        
        print("Annotation '\(selectedLoc!.title!)' has been selected")
        
        
        username = ((selectedLoc?.title)!)!
        shortdes = ((selectedLoc?.subtitle)!)!
        
   
        mapview.reloadInputViews()
        
        self.photos.removeAll(keepCapacity: true)
       
     
        name.text = username
        bio.text = shortdes
        loadpropic()
        
        
        
        self.profilepic.layer.borderWidth = 0.1
        self.profilepic.layer.masksToBounds = false
        self.profilepic.layer.borderColor = UIColor.blackColor().CGColor
        self.profilepic.layer.cornerRadius = self.profilepic.frame.height/2
        self.profilepic.clipsToBounds = true
        
        loadphoto()
        
        
        collectionview.reloadData()
        
        //collectionview.reloadInputViews()
       // collectionview.reloadData()
  
        
        print(photos.count)
    }
    
    func loadpropic () {
    
        let queryuser = PFUser.query()!// PFQuery(className: "User")
        print(username)
        
        queryuser.whereKey("username", equalTo:username)
        
        queryuser.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
            
                var counter = 0
                
                print("object count: \(objects.count)")
                while  counter < objects.count {
                    let object = objects[counter]
                    
                    if let image = object["profileimages"] as? PFFile {
                        image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                            if error == nil {
                                if let imagedata = imagedata{
                                    let image = UIImage(data:imagedata)
//                                    var pic = image!
                                    self.profilepic.image = image!
                                   
                                }
                            }
                        })
                    }
                    
                counter++
                }
            
            }
        }
    
    
    
    }
    
   func loadphoto () {
    
        
        let query = PFQuery(className: "Photo")
        
       query.whereKey("belongstoname", equalTo:username)
    
        
        
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
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
                    
                    counter++
                    self.collectionview.reloadData()

                    
                }
            }
            
            

        }
    
    }
    
    
   
    
    
    @IBOutlet var collectionview: UICollectionView!
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("rows")
        return self.photos.count

    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MapCollectionViewCell
        
        cell.image.image = self.photos[indexPath.row].image
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var bio: UILabel!

    @IBOutlet var pricehighest: UILabel!
    @IBOutlet var pricelowest: UILabel!
    
 
    @IBOutlet var name: UILabel!
    
    @IBOutlet var profilepic: UIImageView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
