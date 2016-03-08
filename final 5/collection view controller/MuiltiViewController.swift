//
//  MuiltiViewController.swift
//  collection view controller
//
//  Created by Joyce Cheung on 6/1/16.
//  Copyright © 2016 Joyce Cheung. All rights reserved.
//

import UIKit

class MuiltiViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , UICollectionViewDelegate , UICollectionViewDataSource{

    var photos : [Photo] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuse", forIndexPath: indexPath) as! MultiTableViewCell
        
        
        cell.collectionview.index = indexPath.row
        cell.collectionview.dataSource = self
        cell.collectionview.delegate = self
        
        
        if cell.collectionview.index == 1 {
            cell.imageView?.image = UIImage(named: "poster2.jpg")
       
        
        
        }
            cell.collectionview.reloadData()
        
        
        
     return cell
    }

    
    @IBOutlet var tableview: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let collectionview = collectionView as? multicollectionview {
//            
//            
//            
//            return collectionview.index
//        }
//        
//        //        if (collectionView)
//        return 4
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell",  forIndexPath: indexPath) as! muiltiCollectionViewCell
//       
//        
//        
//        if indexPath.row == 1 {
//        cell.image.image = UIImage(named: "poster5.jpg")
//        }
//        return cell
//    }
//
//    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
