//
//  SearchPageViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 22/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit

class SearchPageViewController: UIViewController, UICollectionViewDataSource , UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchcollection.dataSource = self
        searchcollection.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let typesofart = ["logo", "poster", "illustration", "leaflet"]
    
    let imageArray = [UIImage(named: "logocover.jpg"), UIImage(named: "poster.jpg"), UIImage(named: "illustration 2.jpg"), UIImage(named: "leaflet.jpg")]
    
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
        
    }
    
    @IBOutlet var searchcollection: UICollectionView!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
