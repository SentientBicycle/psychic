//
//  SideBarTableViewController.swift
//  psychic
//
//  Created by Joel Kelly on 2/11/15.
//  Copyright (c) 2015 Sleepy Mongoose. All rights reserved.
//

import UIKit

protocol SideBarTableViewControlerDelegate{
    func sideBarControlDidSelectLoad(indexPath: NSIndexPath)
}

class SideBarTableViewController: UITableViewController {

    var delegate:SideBarTableViewControlerDelegate?
    var tableData: Array<String> = []

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tableData.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            
            //Configure the Cell
            cell!.backgroundColor       = UIColor.clearColor()
            cell!.textLabel?.textColor  = UIColor.darkTextColor()
            
            let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
                selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            
            cell!.selectedBackgroundView = selectedView
        }
        
        cell!.textLabel?.text = tableData[indexPath.row]
        
        return cell!

    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.sideBarControlDidSelectLoad(indexPath)
    }
}
