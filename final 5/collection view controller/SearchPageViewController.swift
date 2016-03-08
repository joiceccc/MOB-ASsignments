//
//  SearchPageViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 22/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit
import Parse

class SearchPageViewController: UIViewController, UICollectionViewDataSource , UICollectionViewDelegate , UITextFieldDelegate {
   
    var image =  UIImage(named: "mapooo.png")
    let font: UIFont = UIFont(name: "HelveticaNeue-UltraLight", size: 17)!
    @IBOutlet var scroll: UIScrollView!
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchcollection.dataSource = self
        searchcollection.delegate = self
        // Do any additional setup after loading the view.
    addtextbox.delegate = self
    scroll.contentSize.height = 500
    
   //   if currentuser = pf
//        if let currentuser = PFUser.currentUser(){
//            
//            if let image = currentuser["profileimages"] as? PFFile {
//                image.getDataInBackgroundWithBlock({ (imagedata, error) -> Void in
//                    if error == nil {
//                        if let imagedata = imagedata {
//                            let image = UIImage(data: imagedata)
//                            self.propic.imageView?.image = image
//                            self.propic.imageView?.frame = CGRect (x: 3, y: 3, width: 10, height: 10)                        }
//                    }
//                })
//            }
//        
//    }
    }
//    override func viewDidAppear(animated: Bool) {
//       
//        
//        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "nat bar.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(1, 10, 20, 0), resizingMode: .Stretch), forBarMetrics: .Default)
//
////        var nav = self.navigationController?.navigationBar
////        let imageview = UIImageView(frame: CGRect(x: -10, y: 0, width: 60, height: 60))
////        imageview.contentMode = .ScaleAspectFill
////        imageview.image = image
////        
////        navigationItem.titleView = imageview
//        let color = UIColor.blueColor()
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeue-UltraLight", size: 17)!,NSForegroundColorAttributeName: color], forState: .Normal)
//    }
//    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBOutlet var propic: UIButton!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    let typesofart = ["eat", "drink","fashion", "chill", "jewellery", "learn" ]
    
    let imageArray = [UIImage(named: "eating.png"), UIImage(named: "bar.jpg"),UIImage(named: "fashion.jpg"), UIImage(named: "chilling.jpg"), UIImage(named: "jews.jpg"), UIImage(named: "learn.jpg")]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("rows")
        print(self.typesofart.count)
        return self.typesofart.count
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = searchcollection.dequeueReusableCellWithReuseIdentifier("identifier", forIndexPath: indexPath) as! seachcollectionviewcell
        cell.images?.image = self.imageArray[indexPath.row]
        cell.label.text = self.typesofart[indexPath.row]
        
       
        
                print(indexPath.row)
        return cell
    }
//    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("showsearchtags", sender: self)
//        
//    }
//    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("searchtags", sender: self)
    
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("preparing")
        
        if segue.identifier == "searchtags" {
        
        
        let indexPaths = self.searchcollection!.indexPathsForSelectedItems()!
            let indexpath = indexPaths[0] as NSIndexPath
            
            print( "print" + typesofart[indexpath.row] )
            let showtags = segue.destinationViewController as! searchtagsViewController
            
            showtags.transfering = self.typesofart[indexpath.row]
            
        }
        
        if segue.identifier == "search" {
        
        let text = segue.destinationViewController as! searchtagsViewController
        
            text.transfering = self.addtextbox.text!
            
        }
        
        
        
    }
    
    @IBOutlet var searchcollection: UICollectionView!

    @IBAction func hair(sender: AnyObject) {
  
        if addtextbox.text == nil {
            addtextbox.text = "hair "} else {
            
            addtextbox.text = addtextbox.text! + "hair "
            
        }    }
    
    @IBAction func tattoo(sender: AnyObject) {
        
        if addtextbox.text == nil {
            addtextbox.text = "tattoo "} else {
            
            addtextbox.text = addtextbox.text! + "tattoo "
            
        }
    
    
    }
    
    @IBAction func food(sender: AnyObject) {
        if addtextbox.text == nil {
            addtextbox.text = "cafe "} else {
            
            addtextbox.text = addtextbox.text! + "cafe "
            
        }
    }
    @IBAction func graphic(sender: AnyObject) {
        if addtextbox.text == nil {
            addtextbox.text = "chill "} else {
            
            addtextbox.text = addtextbox.text! + "chill "
            
        }    }
    
    @IBAction func art(sender: AnyObject) {
    
        if addtextbox.text == nil {
            addtextbox.text = "art "} else {
            
            addtextbox.text = addtextbox.text! + "art "
            
        }
    }
    @IBAction func blackandwhite(sender: AnyObject) {
        
        if addtextbox.text == nil {
            addtextbox.text = "blackandwhite "} else {
            
            addtextbox.text = addtextbox.text! + "blackandwhite "
            
        }
    
    
    }
    
    @IBAction func life(sender: AnyObject) {
    
        if addtextbox.text == nil {
            addtextbox.text = "plant "} else {
        
        addtextbox.text = addtextbox.text! + "plant "
        
        }
    }
    
    @IBOutlet var graphic: UIButton!
    
    @IBOutlet var addtextbox: UITextField!
    
    
    
    
    @IBAction func search(sender: AnyObject) {
    print("searching")
        
        self.performSegueWithIdentifier("search", sender: self)
        
        
        
        
        }
    
    
    
//
//     override func   prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//            print("preparing")
//            
//            if segue.identifier == "searchtags"
//    }
    
    /*
    @IBOutlet var searchbutton: UIButton!
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
