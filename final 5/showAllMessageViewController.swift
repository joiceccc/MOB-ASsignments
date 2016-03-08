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

    var messageDict: [PFObject:[Message]] = [:]

    var users : [PFObject] = []
    
    var messages: [Message] = [Message()]
    
    
    
    @IBOutlet var tableview: UITableView!
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)  as! SearchMessageTableViewCell
        
        
        cell.message.text = self.messages[indexPath.row].messagetouser
        
        cell.user.text = self.messages[indexPath.row].messagefromuser
        
        cell.propic.image = self.messages[indexPath.row].proimage
       
        cell.propic.layer.borderWidth = 0.05
       cell.propic.layer.masksToBounds = false
        cell.propic.layer.borderColor = UIColor.blackColor().CGColor
        cell.propic.layer.cornerRadius = cell.propic.frame.height/2
       cell.propic.clipsToBounds = true

        
        return cell
        
    }
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("showsearch", sender: self)
//        
//    }

//    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("showallmessage", sender: self)
//
//    }
//    
    
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         if segue.identifier == "showallmessage" {
        
        let destinationOptional = segue.destinationViewController as? MessageToUsersViewController
        if let destination = destinationOptional {
            let indexPath = self.tableview.indexPathForSelectedRow
            if let indexPath = indexPath {
               
               destination.touser = messages[indexPath.row].user
            }
        }
        
         } else {"NOOOOOOOOOO"}
    }
    //
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
    
   
   
    
    
    
    
    override func viewDidLoad() {
        
        var search = searchtextbox.text
        super.viewDidLoad()
tableview.dataSource = self
        // Do any additional setup after loading the view.
    
       var user = []
        messages = []
        
        if let currentuser = PFUser.currentUser() {
            print("current")
            print(currentuser.username)
            
            var findUsers:PFQuery =  PFUser.query()!
            
            
            findUsers.whereKey("username", containsString: "")
            var messagerecieved = PFQuery(className: "Message")
            
            messagerecieved.whereKey("recepiant", equalTo: currentuser)
            
            //messagerecieved.orderByAscending("updatingAt")
            //              messagerecieved.orderByDescending("updatingAt")
            var messagesent = PFQuery(className: "Message")
            
            messagesent.whereKey("sender", equalTo: currentuser)
                        //messagesent.orderByDescending("updatingAt")
            
            
            var usermessage = PFQuery.orQueryWithSubqueries([messagesent, messagerecieved])
            
           
            usermessage.orderByAscending("updatingAt")
            
             usermessage.includeKey("sender")
            
            usermessage.includeKey("recepiant")
            
            usermessage.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
        
        if let objects = objects {
            
            self.users = objects
            
            var uniqueMessages:[PFObject] = []
            var uniqueUser:[String] = []
            var sender :[String] = []
            
            
            
            for object in objects {
                var recipient = object["recepiant"] as! PFUser
                var sender = object["sender"] as! PFUser
                
                if (recipient == currentuser) {
                    if (!uniqueUser.contains(sender.objectId!)) {
                        uniqueUser.append(sender.objectId!)
                        
                       
                        uniqueMessages.append(object)
                    }
                }
                // need to do for current user is sender
                
                if (sender == currentuser) {
                    if (!uniqueUser.contains(recipient.objectId!)) {
                        uniqueUser.append(recipient.objectId!)
                        
                        uniqueMessages.append(object)
                    }
                }
                
            }
            
            
            
            print("uniqueeeeee")
            print(uniqueMessages)
            
//            self.messages
            
            
            for unique in uniqueMessages {
               
                
                let message = Message()
               
                
                
                
                print(" Messssaageeeeee")
                print(unique["text"])
            
                message.messagetouser = unique["text"] as! String
                
               // message.messagefromuser = unique["sender"]
              
               
                if let user = unique["sender"]
                    as? PFObject {
                        
                        
                        print("Senderrrrrrrrr")
                        //  print(user)
                        print(user["username"])
                        
                       
                        
                        if currentuser.username!  ==  user["username"] as! String {
                            
                            if let user = unique["recepiant"]
                                as? PFObject {
                                    
                                    
                                    print("REcepiantttttt")
                                    //  print(user)
                                    print(user["appearname"])
                                    message.messagefromuser = user["username"] as! String
                                    if let image = user["profileimages"] as? PFFile {
                                        image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                                            if error == nil {
                                                if let imagedata = imagedata {
                                                    let image = UIImage(data: imagedata)
                                                    message.proimage = image!
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                   message.user = user
                                                    self.tableview.reloadData()
                                                }
                                            }
                                        })
                                    }

                            
                            }

                        
                        } else { message.messagefromuser = user["username"] as! String
                    print("userrrrrnameeeeee")
                            print(user["username"])
                            print(user["location"])
                           
                            
                            
                            if let image = user["profileimages"] as? PFFile {
                                image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
                                    if error == nil {
                                        if let imagedata = imagedata {
                                            let image = UIImage(data: imagedata)
                                            message.proimage = image!
                                            
                                           self.tableview.reloadData()
                                        }
                                    }
                                })
                            }
                            
                              message.user = user

                                          }
                
                
              
                self.messages.append(message)
               
                
            }
            
            
            
            
            var counter = 0
            
            
//            while counter < objects.count {
//              
//                
//                let message = Message()
//            let object = objects[counter]
//             
////                if let user = object["sender"]
////                    as? PFObject {
////              
////                        
////                        print("usernameeeeee")
////                        print(user["username"])
////                        message.user = user
////                
////                        
////
////                }
//                
//                
//                self.messages.append(message)
//                if let text = object["text"] as? String{
//                    
//                    message.messagetouser = text
//                    
//                    
//                    print("texttttttt")
//                    print(message.messagetouser)
//                    
//                }
//               
//                print("list")
//  //if let users as? String {}
//              //     users.append(objects["username"])
//                 counter++
//                }
            self.tableview.reloadData()
            }
        }
        
        
        }
    }
    
    
    

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
