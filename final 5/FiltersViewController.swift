//
//  FiltersViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 14/1/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.delegate = self
        self.collectionview.dataSource = self

     collectionview.reloadData()
        self.navigationController!.navigationBar.topItem!.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        // Do any additional setup after loading the view.
    }
    
    var parentVC = searchtagsViewController()
    
    
    var selecthk : Bool = false
    var selectkow : Bool = false
    var selectnt : Bool = false
    var currentvalue = 0
    var starvalue = 0
    var indexpath = ""
    
let alpha = ["A", "b", "c", "d"]
    
    let hongkong = ["Aberdeen", "Causewaybay" , "SoHo", "Central", "Happy Valley", "Pok Fu lam" , "Sheung wan" , "Stanley" , " Wan Chai"]
    
    let kowloon = [ "Cheung Sha Wan " , "Choi hung" , "Diamond Hill" , "Ho man Tin", "Jordan ", "Kowloon City", "Mong Kok" , "Tsim Sha Tsui"]
    
    let newteritory = ["Sai Kung", "Sha Tin", "Tsuen Wan ", "Tuen Mun" , "Tai Po" , " Yuen Long " , "Kwai Fong", "Sham Tseng"]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        
        return kowloon.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCellWithReuseIdentifier("locations", forIndexPath: indexPath) as! filtersCollectionViewCell
      
        if selecthk == true {   cell.label.text = hongkong[indexPath.row] }
        
        
        else if selectkow == true {
        
        cell.label.text = kowloon[indexPath.row]
        }
        
        else if selectnt == true {
            cell.label.text = newteritory[indexPath.row]
        } else
        {cell.label.text = kowloon[indexPath.row] }
        
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//        let indexpaths = self.collectionview.indexPathsForSelectedItems()!
//         indexpath = indexpaths[0] as NSIndexPath
//        
//        let vc = segue.destinationViewController as! ViewController2
//        
//        vc.image = self.photos[indexpath.row].image
//        vc.caption = self.photos[indexpath.row].caption
//        

        let indexpaths = self.collectionview.indexPathsForSelectedItems()!
               
            
        

        
    }
    
    @IBOutlet var pricelabel: UILabel!
    @IBAction func price(sender: AnyObject) {
       
        var currentvalue = Int(price.value)
        pricelabel.text = "$" + String(currentvalue)
        
    }
    @IBOutlet var price: UISlider!
    
    @IBOutlet var starslide: UISlider!
    
    @IBAction func starslide(sender: AnyObject) {
        
        var starvalue = Int(starslide.value)
        if starvalue == 1 {
            
            star.image = UIImage(named: "1.png")
           
        }
        else if starvalue == 2 {
            
            star.image = UIImage(named: "2.png")
            
        }
        else if starvalue == 3 {
            
            star.image = UIImage(named: "3.png")
           
        }
        else if starvalue == 4 {
            star.image = UIImage(named: "4.png")
           
            
        }
        else if starvalue == 5 {
            star.image = UIImage(named: "5.png")
            
            
        
        
    }
    
    }
    
    
    
    @IBOutlet var star: UIImageView!
    
    
    @IBAction func newteritory(sender: AnyObject) {
        
        selectnt = true
        selecthk = false
        selectkow = false
        collectionview.reloadData()
        
    }
    @IBAction func kowloon(sender: AnyObject) {
        selectnt = false
        selecthk = false
        selectkow = true
        collectionview.reloadData()
        
    }
    
    @IBAction func hongkong(sender: AnyObject) {
        selectnt = false
        selecthk = true
        selectkow = false
        collectionview.reloadData()
        
    }
    
    @IBAction func search(sender: AnyObject) {
        parentVC.district = "kowloon"
        
        
        
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet var collectionview: UICollectionView!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
