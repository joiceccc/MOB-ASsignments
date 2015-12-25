//
//  SearchUsersViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 17/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class SearchUsersViewController: UIViewController, UITableViewDataSource {

    
    
    @IBOutlet var tableview: UITableView!
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        
        cell.textLabel?.text = users[indexPath.row]["username"] as? String
       
        //self.performSegueWithIdentifier("searchuser", sender: self)

        
        return cell
        
    }
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("showsearch", sender: self)
//        
//    }

    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showsearch", sender: self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let destinationOptional = segue.destinationViewController as? OtherUserViewController
        if let destination = destinationOptional {
            let indexPath = self.tableview.indexPathForSelectedRow
            if let indexPath = indexPath {
               
               destination.user = users[indexPath.row]
            }
        }
        
    }//
//        let destinationOptional = segue.destinationViewController as? StudentDetailsViewController
//        
//        if let destination = destinationOptional {
//            
//            
//            
//            let indexPath = self.tableView.indexPathForSelectedRow
//            
//            if let indexPath = indexPath {
//                
//                print(indexPath.row)
//                print(students[indexPath.row])
//                
//                destination.name = students[indexPath.row]
//            }
//            
//            
//            
//        }
//        
//    }


    @IBOutlet var searchtextbox: UITextField!
    
    var users : [PFObject] = []
   
    
    
    
    
    override func viewDidLoad() {
        
        var search = searchtextbox.text
        super.viewDidLoad()
tableview.dataSource = self
        // Do any additional setup after loading the view.
    
       var user = []
        
        if let currentuser = PFUser.currentUser() {
            print("current")
            print(currentuser.username)

              var findUsers:PFQuery =  PFUser.query()!
            findUsers.whereKey("username", containsString: "")
    
     findUsers.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
        
        
        if let objects = objects {
            
            self.users = objects
            var counter = 0
//            while counter < objects.count {
//               counter++
//                print(counter)
//                print("hello")
//            let object = objects[counter]
//            
//                print("list")
 // if let users as? String {}
//              //     users.append(objects["username"])
//                    
//                }
            self.tableview.reloadData()
            }
        }
        
        
        }
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
