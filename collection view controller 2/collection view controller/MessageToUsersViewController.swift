//
//  MessageToUsersViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 22/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class MessageToUsersViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate {

     var touser : PFObject = PFObject(className: "")
    var messagesArray : [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.messagetableview.dataSource = self
        
        self.messagetableview.delegate = self
        
        self.messagetextbox.delegate = self
        
        label.text = String( touser["username"])
        
        
       var  message = []
        
        if let currentuser = PFUser.currentUser() {
          
            var messagefromuser = PFQuery(className: "Message")
       //  messagefromuser.whereKey("sender", equalTo: touser )
        messagefromuser.whereKey("recepiant", equalTo: touser)
            
            
            var messagetouser = PFQuery(className: "Message")
          // messagetouser.whereKey("recepiant", equalTo: currentuser)
            messagetouser.whereKey("sender", equalTo: currentuser)
            
            
            
            
            var usermessage = PFQuery.orQueryWithSubqueries([messagetouser, messagefromuser])
            
            
            
            usermessage.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if let objects = objects {
                    self.messagesArray = objects
                    
                    self.messagetableview.reloadData()
                    
                }
            })
        // Do any additional setup after loading the view.
    
        
        }
    }

    @IBAction func sendmessage(sender: AnyObject) {
       
        if let currentuser = PFUser.currentUser() {
            
        var text = messagetextbox.text
        
                var message = PFObject(className: "Message")
        
                message["text"] =  currentuser.username! + ":" + text!
        
                message["sender"] = PFUser.currentUser()
                message["recepiant"] = touser
        
                message.saveInBackground()
        
    
    }
    
    }
  
    
//    func retreiveMessage () {
//        
//        
//        var query:PFQuery = PFQuery(className: "Message")
//        
//        
//        query.findObjectsInBackgroundWithBlock { ( objects, error) -> Void in
//            
//            self.messagesArray = [String]()
//            
//            for messageobject in objects! {
//            
//                let messageText:String? = (messageobject as PFObject["Text"] as? String)
//            }
//            
//            
//        }
//    }
    
    
    
    @IBOutlet var messagetextbox: UITextField!
    
    @IBOutlet var label: UILabel!
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
         let cell = messagetableview.dequeueReusableCellWithIdentifier("showmessage", forIndexPath: indexPath)
        
        cell.textLabel?.text = messagesArray[indexPath.row]["text"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var messagetableview: UITableView!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
