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

    let filter = CIFilter(name: "CICircleSplashDistortion")
    let context = CIContext(options: nil)
    var extent: CGRect!
    var scaleFactor: CGFloat!
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
        
        
//        scaleFactor = UIScreen.mainScreen().scale
//        extent = CGRectApplyAffineTransform(UIScreen.mainScreen().bounds,CGAffineTransformMakeScale(scaleFactor, scaleFactor))
//        
//        let ciImage = CIImage(image: image.image!)
//        filter?.setDefaults()
//        filter?.setValue(ciImage, forKey: kCIInputImageKey)
//        image.image = UIImage(CGImage: context.createCGImage((filter?.outputImage)!, fromRect: extent))
//        
//        pan.addTarget(self, action: "panned:")
        
        
        // Do any additional setup after loading the view.
    }
    
//    func panned(gesture: UIGestureRecognizer) {
//    
//        let location = gesture.locationInView(image)
//        let x = location.x * scaleFactor
//        let y = image.bounds.height * scaleFactor - location.y * scaleFactor
//        filter?.setValue(CIVector(x: x, y: y), forKey: kCIInputCenterKey)
//        
//         image.image = UIImage(CGImage: context.createCGImage((filter?.outputImage)!, fromRect: extent))
//    }
//    
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
        
        let caption : String = captiontextbox.text!
        
        if let currentuser = PFUser.currentUser() {
        
            
            let photo = PFObject(className: "Photo")
            photo["caption"] = caption
            photo["belongsto"] = currentuser
            photo["belongstoname"] = currentuser.username
            
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
    
    
    @IBOutlet var pan: UIPanGestureRecognizer!
    

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
