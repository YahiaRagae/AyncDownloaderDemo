//
//  ViewController.swift
//  AyncDownloaderDemo
//
//  Created by Yahia Work on 11/21/16.
//  Copyright © 2016 Yahia. All rights reserved.
//

import UIKit
import ADMozaicCollectionViewLayout

class ViewController: UIViewController,UICollectionViewDataSource,ADMozaikLayoutDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var pins : [Pins] = []
    
    // MARK: UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        loadData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        initViews()

    }
    
    // MARK: Class Methods
    func initData(){
        
    }
    
    func initViews(){
        let columnWidth = UIScreen.mainScreen().bounds.width/3
        var portraitLayout: ADMozaikLayout {
            let columns = [  ADMozaikLayoutColumn(width: columnWidth), ADMozaikLayoutColumn(width: columnWidth), ADMozaikLayoutColumn(width: columnWidth)]
            let layout = ADMozaikLayout(rowHeight: 120, columns: columns)
            layout.delegate = self
            layout.minimumLineSpacing = 1
            layout.minimumInteritemSpacing = 1
            return layout;
        }
        
        collectionView.setCollectionViewLayout(portraitLayout, animated: true)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    func loadData(){
        DataAccessController.sharedInstance.getImagesList(onView: self.view) { (imagesList) in
            self.pins.appendContentsOf(imagesList)
            self.collectionView.reloadData()
            
        }
    }
    // MARK: UICollectionViewDataSource Methods
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
                
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ADMozaikLayoutCell", forIndexPath: indexPath) as UICollectionViewCell
        let imageView: UIImageView = cell.viewWithTag(1000) as! UIImageView
       imageView.image = nil
       imageView.alpha = 0
        let pin : Pins = pins[indexPath.row]

        imageView.loadImage(pin.images![0].url!, isIgnoreCaching: false)
        

        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pins.count
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // MARK: UICollectionViewDelegate Methods
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, mozaikSizeForItemAtIndexPath indexPath: NSIndexPath) -> ADMozaikLayoutSize {
        if indexPath.item == 0 {
            return ADMozaikLayoutSize(columns: 1, rows: 1)
        }
        if indexPath.item % 8 == 0 {
            return ADMozaikLayoutSize(columns: 2, rows: 2)
        }
        else if indexPath.item % 6 == 0 {
            return ADMozaikLayoutSize(columns: 3, rows: 1)
        }
        else if indexPath.item % 4 == 0 {
            return ADMozaikLayoutSize(columns: 1, rows: 3)
        }
        else {
            return ADMozaikLayoutSize(columns: 1, rows: 1)
        }
    }

  
}


