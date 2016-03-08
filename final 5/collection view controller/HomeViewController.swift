//
//  HomeViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 16/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController , UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        username.delegate = self
        password.delegate = self
        incorrect.hidden = true
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet var login: UIButton!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
        
    @IBOutlet var password: UITextField!
    @IBOutlet var username: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        
        var inputusername = username.text
        var inputpassword = password.text
        
        PFUser.logInWithUsernameInBackground(inputusername!, password: inputpassword!) { (user, error) -> Void in
                    if (error == nil)
                    { print(user)
                        print(user?.username)
                      self.performSegueWithIdentifier("login", sender: self)
                    
                    
                    }
                        else
                    { print("login failed")
                        self.self.incorrect.hidden = false
                        
                        }
                    }
            

        
    }

    @IBOutlet var incorrect: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
