//
//  TableTableViewController.swift
//  tableViewTests
//
//  Created by Ryan Solida on 3/28/15.
//  Copyright (c) 2015 Ryan Solida. All rights reserved.
//

import UIKit
import MapKit

class TableTableViewController: UITableViewController {
    
    var headerView = UIView()
    var headerScrollView = UIScrollView()
    var sliderScrollView = UIScrollView()
    var topRowHeight: CGFloat = 0
    var rowHeight: CGFloat = 80
    var statusAndNavBarHeight: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
      
        
        var navBarHeight = self.navigationController!.navigationBar.frame.height
        var statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        var bottomOfNavBar = navBarHeight + statusBarHeight
        self.statusAndNavBarHeight = bottomOfNavBar
        
        self.tableView.backgroundColor = UIColor.blueColor()
        println( self.view.frame.height)
        self.topRowHeight = self.view.frame.height - (self.rowHeight + self.statusAndNavBarHeight) - self.rowHeight
        println(self.topRowHeight)
        self.tableView.contentOffset.y = 200
        
        let mapView = MKMapView(frame: self.view.frame)
        self.tableView.backgroundView = mapView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 20
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        if ( indexPath.row == 0 ){
            cell = tableView.dequeueReusableCellWithIdentifier("trans", forIndexPath: indexPath) as UITableViewCell
            cell.backgroundColor = UIColor.clearColor()
        } else if ( indexPath.row == 1 ){
            cell = tableView.dequeueReusableCellWithIdentifier("stickyHeader", forIndexPath: indexPath) as UITableViewCell
            
            

            
            if ( self.sliderScrollView.frame.height == 0 ){ //so it doesn't get reinitialized
                var scrollView = cell.viewWithTag(1) as UIScrollView
                scrollView.delegate = self
                self.sliderScrollView = scrollView
                var scrollViewView = scrollView.viewWithTag(1) as UIView!
                scrollView.contentSize = CGSize(width: 750, height: scrollViewView.frame.height)
            }

        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("dataCell", forIndexPath: indexPath) as UITableViewCell
            var row = indexPath.row
            cell.textLabel?.text = "Stuff \(row)"
            cell.separatorInset = UIEdgeInsetsMake(0, -15, 0, 0)
        }

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if ( indexPath.row == 0 ){
            return self.topRowHeight
        }
        return self.rowHeight
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if ( scrollView == self.headerScrollView ){
            self.sliderScrollView.contentOffset = scrollView.contentOffset
        } else if ( scrollView == self.sliderScrollView ){
            self.headerScrollView.contentOffset = scrollView.contentOffset
        } else if ( scrollView == self.tableView ) {

            var bottomOfNavBar = self.statusAndNavBarHeight * -1

            if ( scrollView.contentOffset.y > (self.rowHeight + self.topRowHeight + bottomOfNavBar) ){
                self.headerView.hidden = false
            } else {
                self.headerView.hidden = true
            }
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerViewCell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("stickyHeader") as? UITableViewCell
        
        if let view = headerViewCell?.contentView {
            self.headerView = view
            
            var scrollView = self.headerView.viewWithTag(1) as UIScrollView
            scrollView.delegate = self
            self.headerScrollView = scrollView
            var scrollViewView = scrollView.viewWithTag(1) as UIView!
            scrollView.contentSize = CGSize(width: 800, height: scrollViewView.frame.height)

            self.headerView.backgroundColor = UIColor.whiteColor()
            self.headerView.hidden = true
            return view
        } else {
            return UIView()
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.rowHeight
    }

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
