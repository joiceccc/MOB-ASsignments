//
//  TypeOfProviderViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 15/2/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class TypeOfProviderViewController: UIViewController {

    var pickedupstairs : Bool = false
   
     var pickedground : Bool = false
    
     var pickedindividual : Bool = false
    
     var pickedblogger : Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
        
        individual.alpha = 0.65
    
        individuallabel.alpha = 0.65
        
        upstairs.alpha = 0.65
    
        upstairslabel.alpha = 0.65
        
        ground.alpha = 0.65
        
        groundlabel.alpha = 0.65
        
        blogger.alpha = 0.65
        bloggerlabel.alpha = 0.65
        
        self.navigationController!.navigationBar.topItem!.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registered(sender: AnyObject) {
    
        
        if let currentuser = PFUser.currentUser() {
            print("current")
            print(currentuser.username)
            
            if pickedindividual == true {
                currentuser["type"] = "individual" }
            
            if pickedupstairs == true {
                currentuser["type"] = "upstairs" }
           
            if pickedblogger == true {
                currentuser["type"] = "blogger" }
            
            if pickedground == true {
                currentuser["type"] = "ground"
            }
            
            currentuser.saveInBackground()
        
    self.performSegueWithIdentifier("doneregistered", sender: self)
    
    
    
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
    @IBOutlet var groundlabel: UILabel!
    @IBAction func gound(sender: AnyObject) {
        var pickedupstairs : Bool = false
        
        var pickedground : Bool = true
        
        var pickedindividual : Bool = false
        
        var pickedblogger : Bool = false
    
    ground.alpha = 1
        groundlabel.alpha = 1
        individual.alpha = 0.3
        
        individuallabel.alpha = 0.3
        
        upstairs.alpha = 0.3
        
        upstairslabel.alpha = 0.3
        
        
        
        blogger.alpha = 0.3
        bloggerlabel.alpha = 0.3
        

    
    }
    @IBOutlet var ground: UIButton!
    @IBOutlet var upstairslabel: UILabel!
    @IBAction func upstairs(sender: AnyObject) {
        
        var pickedupstairs : Bool = true
        
        var pickedground : Bool = false
        
        var pickedindividual : Bool = false
        
        var pickedblogger : Bool = false
        
        upstairs.alpha = 1
       upstairslabel.alpha = 1
        
        individual.alpha = 0.3
        
        individuallabel.alpha = 0.3
        
        
        
        ground.alpha = 0.3
        
        groundlabel.alpha = 0.3
        
        blogger.alpha = 0.3
        bloggerlabel.alpha = 0.3
        

        
    }
    @IBOutlet var upstairs: UIButton!
    @IBAction func individual(sender: AnyObject) {
        
        var pickedupstairs : Bool = false
        
        var pickedground : Bool = false
        
        var pickedindividual : Bool = true
        
        var pickedblogger : Bool = false
        
        individuallabel.alpha = 1
        individual.alpha = 1
        
        
        upstairs.alpha = 0.3
        
        upstairslabel.alpha = 0.3
        
        ground.alpha = 0.3
        
        groundlabel.alpha = 0.3
        
        blogger.alpha = 0.3
        bloggerlabel.alpha = 0.3
        

        
        
        
    }

    @IBOutlet var individuallabel: UILabel!
    @IBOutlet var individual: UIButton!


    @IBOutlet var blogger: UIButton!


    @IBAction func blogger(sender: AnyObject) {
   
        var pickedupstairs : Bool = false
        
        var pickedground : Bool = false
        
        var pickedindividual : Bool = false
        
        var pickedblogger : Bool = true
        
        blogger.alpha = 1
        bloggerlabel.alpha = 1
        
        individual.alpha = 0.3
        
        individuallabel.alpha = 0.3
        
        upstairs.alpha = 0.3
        
        upstairslabel.alpha = 0.3
        
        ground.alpha = 0.3
        
        groundlabel.alpha = 0.3
        
        
        

    
    
    
    
    }


    @IBOutlet var bloggerlabel: UILabel!





}
