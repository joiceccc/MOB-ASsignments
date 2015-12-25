//
//  searchtagsViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 17/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse


class searchtagsViewController: UIViewController , UITableViewDataSource {

    
    
    
    var transfering = ""
    
    
    override func viewDidLoad() {
        loadphotos()
        tableview.dataSource = self
        super.viewDidLoad()

        label.text = transfering
       
       
        // Do any additional setup after loading the view.
    }
    var photos : [Photo] = []
//    var photosi:[PFObject] = []
   
    override func viewDidAppear(animated: Bool) {
        self.label.text = transfering

    }
    
   
    @IBOutlet var tableview: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        if let currentuser = PFUser.currentUser() {
            
        
        }
        
        let cell = tableview.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! tagsTableViewCell
        
        
       // cell.textLabel?.text = photos[indexPath.row].caption
       //     cell.imageView?.image = photos[indexPath.row].image
        cell.label.text = photos[indexPath.row].caption
        cell.postimage.image = photos[indexPath.row].image
        cell.namelabel.text = photos[indexPath.row].byuser
       // cell.image2.image = photos[indexPath.row].userimage
        return cell
        
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
        
            
            
            let query = PFQuery(className: "Photo")
        query.whereKey("tags", containsString: transfering )
            //            query.whereKey("caption", containsString: "caption")
            query.findObjectsInBackgroundWithBlock  ({ (objects, error) -> Void in
              
                
                if let objects = objects {
                  //  self.photos = objects
                    var counter = 0
                    while counter < objects.count {
                    
                        
                        print(counter)
                        let photo = Photo()
                        
                    let object = objects[counter]
                     self.photos.append(photo)
                        
                    
                        if let caption = object["caption"] as? String {
                            photo.caption = caption
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
                        
                        
                       if  let pfOject:PFObject = object {
                            if  let usersobject:PFUser = pfOject["belongsto"]as? PFUser {
                                
                             //   print( usersobject.objectId!)
                                
                                
                                photo.byuser = usersobject.objectId!
                               // photo.byuser = usersobject.username!
                                
                            
                                
                               //  print( usersobject.username!)
                            }
                            
                        }

                        
                        
                 counter++
                    
                }
                }
            })
        
    
}
}