//
//  ProfileViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 15/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse
import MapKit


class ProfileViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource, UISearchBarDelegate{
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!

    @IBOutlet var profilepic: UIImageView!
    
    @IBOutlet var collectionview: UICollectionView!
    
    @IBOutlet var map: MKMapView!
    @IBOutlet var whereyoufrom: UILabel!
    
    @IBOutlet var address: UILabel!
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
    
    
    @IBOutlet var scrollview: UIScrollView!
    
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
 self.collectionview.reloadData()
        
        if let currentuser = PFUser.currentUser(){
            
            if let image = currentuser["profileimages"] as? PFFile {
                image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                    if error == nil {
                        if let imagedata = imagedata {
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
            }}

    
    
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
       
        if let currentuser = PFUser.currentUser(){
        
        //1
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        if self.map.annotations.count != 0{
            annotation = self.map.annotations[0]
            self.map.removeAnnotation(annotation)
        }
        //2
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            var lat = localSearchResponse!.boundingRegion.center.latitude
            var long = localSearchResponse!.boundingRegion.center.longitude
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: lat, longitude: long)
            
            
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                // Address dictionary
                print(placeMark.addressDictionary)
                
                // Location name
                if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                    print("name")
                    print(locationName)
                }
                
                // Street address
                if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                    print("street")
                    print(street)
                }
                
                // City
                if let city = placeMark.addressDictionary!["City"] as? NSString {
                   print("city")
                    print(city)
                }
                
                // Zip code
                if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                    print("zip")
                    print(zip)
                }
                
                // Country
                if let country = placeMark.addressDictionary!["Country"] as? NSString {
                    print("country")
                    print(country)
                }
                
                if let lines = placeMark.addressDictionary!["FormattedAddressLines"] as? [NSString] {
                    print("lines")
                    print(lines[0])
                    self.address.text = String(lines)
                currentuser["address"] = String(lines)
                    
                currentuser.saveInBackground()
                }
                
            })

            
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.map.centerCoordinate = self.pointAnnotation.coordinate
        
            self.map.addAnnotation(self.pinAnnotationView.annotation!)
            let point = PFGeoPoint(latitude:lat, longitude:long)
            
            currentuser["location"] = point
            
            currentuser.saveInBackground()
            
            
            }

            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos = []
//        loadphotos()
        
        self.collectionview.reloadData()
       
        scrollview.contentSize.height = 1400
        
        if let currentuser = PFUser.currentUser(){
            
            if let image = currentuser["profileimages"] as? PFFile {
                image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                    if error == nil {
                        if let imagedata = imagedata {
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
            

            let location = CLLocationCoordinate2D(
                latitude: 51.50007773,
                longitude: -0.1246402
            )
            // 2
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            map.setRegion(region, animated: true)
            
            //3
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Enter Location"
            annotation.subtitle = ":)"
            map.addAnnotation(annotation)
            
            
            
           
            
            if let useraddress = currentuser["location"] as? PFGeoPoint {
                print("GEOOOOOOOOOO")
                print (useraddress)
                var long = useraddress.longitude
                var lat = useraddress.latitude
                
                let location = CLLocationCoordinate2D(
                    latitude: lat,
                    longitude: long
                
               
                
                )
                
                 let point = PFGeoPoint(latitude:lat, longitude:long)
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
            
            
            currentuser.saveInBackground()
            
            
        }
        
        
        // Do any additional setup after loading the view.
        
        // 1
       
        
    }
    
    
    
    
    @IBOutlet var searchlocation: UIButton!
    
    @IBAction func searchlocation(sender: AnyObject) {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet var appearname: UILabel!
    
    
    
    func loadphotos () {
        
        if let currentuser = PFUser.currentUser() {
            print("current")
            print(currentuser.username)
            
            username.text = currentuser.username
            appearname.text = String(currentuser["appearname"])
            
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
