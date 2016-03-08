//
//  signuppageViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 14/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class signuppageViewController: UIViewController , UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
    username.delegate = self
    password.delegate = self
    email.delegate = self
        self.navigationController!.navigationBar.topItem!.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

 
    @IBOutlet var username: UITextField!
  
    
    @IBOutlet var password: UITextField!
    
    
    @IBOutlet var email: UITextField!
    

    @IBAction func createusers(sender: AnyObject) {
        
        var enteruser : String = username.text!
        var enterpassword : String = password.text!
        var enteremail : String = email.text!
     
        
              var user = PFUser()
               user.username = enteruser
              user.password = enterpassword
                user.email = enteremail
        
            user.signUpInBackgroundWithBlock { (sucess, error) -> Void in
               print(sucess)
              print(error)
        
        
        self.performSegueWithIdentifier("continueregistered", sender: self)
        
        
        
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
