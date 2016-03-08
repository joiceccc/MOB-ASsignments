//
//  searchofviewcontroller.swift
//  collection view controller
//
//  Created by Joyce Cheung on 10/12/15.
//  Copyright © 2015 Joyce Cheung. All rights reserved.
//

import UIKit

class searchofviewcontroller: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        searchposter.dataSource = self
        searchposter.delegate = self
        // Do any additional setup after loading the view.
    }

    
    let typesofart = ["from $ 10", "from $13", "from $ 30", "from $45"]
    
    let imageArray = [UIImage(named: "poster5.jpg"), UIImage(named: "poster6.jpg"), UIImage(named: "poster 7.jpg"), UIImage(named: "poster8.jpg"), UIImage(named: "poster9.jpg"), UIImage(named: "poster 10.jpg")]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("rows")
        print(self.typesofart.count)
        return self.typesofart.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = searchposter.dequeueReusableCellWithReuseIdentifier("identifier", forIndexPath: indexPath) as! posterCollectionViewCell
        cell.images?.image = self.imageArray[indexPath.row]
        cell.label.text = self.typesofart[indexPath.row]
        
        print(indexPath.row)
        return cell
    }

    
    
    @IBOutlet var searchposter: UICollectionView!
    
    
    
    
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
