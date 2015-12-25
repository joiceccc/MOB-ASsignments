//
//  EditProfileViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 15/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse


class EditProfileViewController: UIViewController ,UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagepicker.delegate = self

    
    }
    
    @IBAction func editprofilepic(sender: AnyObject) {
   
        imagepicker.sourceType = .PhotoLibrary
        presentViewController(imagepicker, animated: true, completion: nil)
    
    
    
    }
    
    let imagepicker = UIImagePickerController()
    
    var pickedimaged = UIImage()
    
    @IBOutlet var upload: UIButton!
    
    @IBAction func upload(sender: AnyObject) {
        
        if let currentuser = PFUser.currentUser() {
//            
//            let photo = PFObject(className: "ProfilePicture")
//            photo["belongsto"] = currentuser
            
            
            let imagedata = UIImagePNGRepresentation(pickedimaged)!
            let imagefile = PFFile(name: "profileimage.png", data: imagedata )
            
            currentuser["profileimages"] = imagefile
            
            
            currentuser.saveInBackground()
        
        }
        
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            self.pickedimaged = pickedimage
            
            
            self.images.image = pickedimage
        }
        
        dismissViewControllerAnimated(true , completion: nil)
    }

    
    @IBOutlet var whereyoufrom: UITextField!
    
    @IBOutlet var website: UITextField!

    @IBOutlet var bio: UITextField!
    
    @IBOutlet var images: UIImageView!
    
    @IBAction func saveedit(sender: AnyObject) {
      
        var addwhereyoufrom: String = whereyoufrom.text!
        var addbio : String = bio.text!
        
        
        
        if let currentuser = PFUser.currentUser() {
            print("current")
            print(currentuser.username)
        
            currentuser["from"] = addwhereyoufrom
            
            currentuser["bio"] = addbio
            
            
            //            currentuser["phone"] = 22384993
        currentuser.saveInBackground()
        
   navigationController?.popViewControllerAnimated(true)
        
        
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
