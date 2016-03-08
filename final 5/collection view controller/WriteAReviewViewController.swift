//
//  WriteAReviewViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 18/1/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class WriteAReviewViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UICollectionViewDataSource , UICollectionViewDelegate, UITextViewDelegate

{

    let imagepicker = UIImagePickerController()
    var pickedimaged = UIImage()
    var touser : PFObject = PFObject(className: "")

    var pickedimages:[UIImage]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate = self
        collectionview.delegate = self
        collectionview.dataSource = self
       textboc.delegate = self
        
        // Do any additional setup after loading the view.
        
        
       imagetotal.text = "(" + String(pickedimages.count) + ")"
        imagetotal.reloadInputViews()
        collectionview.reloadData()
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
          self.pickedimaged = pickedimage
            
            self.pickedimages.append(pickedimage)

            
            collectionview.reloadData()
             imagetotal.text = "(" + String(pickedimages.count) + ")"            
            print(pickedimages.count)
//                     self.image1.image = pickedimages[1]
//            if pickedimages.count == 4 {
//                self.image2.image = pickedimages[3]}
//            else if pickedimages.count == 3 {
//         self.image3.image = pickedimages[2]
//            }
        }
        
        dismissViewControllerAnimated(true , completion: nil)
    }
    


    @IBAction func addimage(sender: AnyObject) {
        
        
        imagepicker.sourceType = .PhotoLibrary
        presentViewController(imagepicker, animated: true, completion: nil)
    }
    @IBAction func addstar(sender: AnyObject) {
        
        var starvalue = Int(slider.value)
        if starvalue == 1 {
            
            starimage.image = UIImage(named: "1.png")
            
        }
        else if starvalue == 2 {
            
            starimage.image = UIImage(named: "2.png")
            
        }
        else if starvalue == 3 {
            
            starimage.image = UIImage(named: "3.png")
            
        }
        else if starvalue == 4 {
            starimage.image = UIImage(named: "4.png")
            
            
        }
        else if starvalue == 5 {
            starimage.image = UIImage(named: "5.png")
            
            
            
            
        }
        
    }

    
    @IBAction func addreview(sender: AnyObject) {
        
        if let currentuser = PFUser.currentUser() {
            
            let text = textboc.text
            
            let currentvalue = Int(slider.value)
            
            let comments = PFObject(className: "Comments")
            
            comments["comments"] =  text + "-  " + currentuser.username!
            
            comments["commentfrom"] = currentuser
          comments["commentto"] = ["__type": "Pointer", "className": "_User", "objectId": touser.objectId!]
            
            comments["stars"] = currentvalue
            
            comments.saveInBackgroundWithBlock({ (success, error) -> Void in
                print("comment saved")
                print(success)
                print(error)
            })
            
            
            
            
            
            for pickimage in pickedimages{
                
                let reviewphotos = PFObject(className: "ReviewPhoto")
                print("counting")
                
                let imagedata = UIImagePNGRepresentation(pickimage)!
                let imagefile = PFFile(name: "image.png", data: imagedata )
                
                
                reviewphotos["images"] = imagefile
                reviewphotos["belongsto"] = ["__type": "Pointer", "className": "_User", "objectId": touser.objectId!]
                reviewphotos["belongscomment"] = comments
                reviewphotos["postby"] = currentuser
                
                
                reviewphotos.saveInBackgroundWithBlock({ (success, error) -> Void in
                    print("photo saved")
                    print(success)
                    print(error)
                })
                
            }
    
   navigationController?.popViewControllerAnimated(true)
        
        } else { print ("no image") }
    
    
     
    
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        
        return pickedimages.count    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCellWithReuseIdentifier("reviews", forIndexPath: indexPath) as! writeReviewCollectionViewCell

         cell.image.image = pickedimages[indexPath.row]
        
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet var slider: UISlider!
  
    @IBOutlet var imagetotal: UILabel!
    @IBOutlet var collectionview: UICollectionView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!

    @IBOutlet var addimage: UIButton!
    @IBOutlet var starimage: UIImageView!
    @IBOutlet var textboc: UITextView!
}
