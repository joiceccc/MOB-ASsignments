//
//  AddPhotoViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 15/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDataSource, UIPickerViewDelegate{

    
    
    var pickerdata = [ "poster", "logo", " illustration" , " leaflet"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerdata.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerdata[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
     if let currentuser = PFUser.currentUser() {
        let photo = PFObject(className: "Photo")
           photo["belongsto"] = currentuser
        if (row == 1) { photo["tags"] = "poster" }
        else if (row == 2) {photo["tags"] = "logo" }
        else if (row == 3) {photo["tags"] = "illustration"}
        else if (row == 4) {photo["tags"] = "leaflet"}
        
        photo.saveInBackground()
        }
       
        }
    
    @IBOutlet var picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate = self
        self.picker.delegate = self
        self.picker.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    let imagepicker = UIImagePickerController()
    
    
    @IBOutlet var image: UIImageView!
    
    var pickedimaged = UIImage()
    
    
    @IBAction func addphoto(sender: AnyObject) {
//        imagepicker.editing = true
        imagepicker.sourceType = .PhotoLibrary
        presentViewController(imagepicker, animated: true, completion: nil)
    }
    
    @IBOutlet var captiontextbox: UITextField!
    
    @IBAction func upload(sender: AnyObject) {
        
        if let currentuser = PFUser.currentUser() {
        
            let photo = PFObject(className: "Photo")
            photo["caption"] = "gvgjb"
            photo["belongsto"] = currentuser
            
            
            let imagedata = UIImagePNGRepresentation(pickedimaged)!
            let imagefile = PFFile(name: "image.png", data: imagedata )
            
            photo["images"] = imagefile
        
    
            photo.saveInBackground()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            self.pickedimaged = pickedimage
            
            
            self.image.image = pickedimage
        }
        
        dismissViewControllerAnimated(true , completion: nil)
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
