//
//  ViewController.swift
//  AyncDownloaderDemo
//
//  Created by Yahia Work on 11/21/16.
//  Copyright © 2016 Yahia. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    var refreshView :UIRefreshControl!
    var pageIndex : Int = 0;
    var isLoadMoreEnabled : Bool = true ;
    @IBOutlet weak var table: UITableView!
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
        refreshView = UIRefreshControl()
        refreshView.backgroundColor = UIColor.whiteColor()
        refreshView.addTarget(self, action: #selector(refreshData), forControlEvents:.ValueChanged)
        table.addSubview(refreshView) // not required when using UITableViewController
    }
    func loadData(){
        pageIndex = pageIndex + 1
        DataAccessController.sharedInstance.getImagesList(onView: self.view,pageIndex:pageIndex ) { (imagesList) in
            if(imagesList.count == 0 ){
                self.isLoadMoreEnabled = false;
                self.view.makeToast("No more items :) ")
            }
            self.pins.appendContentsOf(imagesList)
            self.table.reloadData()
            self.refreshView.endRefreshing()
        }
    }
    func refreshData(){
        pageIndex = 0
        self.pins.removeAll()
        loadData()
        isLoadMoreEnabled = true
    }
    
    // MARK: UITableViewDataSource Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  
                
        let cell:ImageCell = tableView.dequeueReusableCellWithIdentifier("ImageCell") as! ImageCell
        
        cell.img?.image = nil
        cell.img.alpha = 0
        let pin : Pins = pins[indexPath.row]
        cell.lblTitle.text = pin.descriptionValue
        cell.img.loadImage(pin.images![0].url!, isIgnoreCaching: false)
        

        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   pins.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let lastSectionIndex = table.numberOfSections - 1 ;
        let lastRowIndex = table.numberOfRowsInSection(lastSectionIndex)-1
        
        if(indexPath.section == lastSectionIndex  && indexPath.row == lastRowIndex){
            loadData()
        }
        
    }
    
    // MARK: UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
  
}


