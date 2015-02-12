//
//  SideBar.swift
//  psychic
//
//  Created by Joel Kelly on 2/11/15.
//  Copyright (c) 2015 Sleepy Mongoose. All rights reserved.
//

import UIKit

@objc protocol SideBarDelegate{
    func sideBarDidSelectButtonAtIndex(index:Int)
    optional func sideBarWillClose()
    optional func sideBarWillOpen()
}

class SideBar: NSObject, SideBarTableViewControlerDelegate {
    
    let barWidth:CGFloat                                        = 150.0
    let sideBarTableViewTopInset:CGFloat                        = 64.0
    let sideBarContainerView:UIView                             = UIView()
    let sideBarTableViewController:SideBarTableViewController   = SideBarTableViewController()
    let originView:UIView!

    var isSideBarOpen:Bool                                      = false
    var animator:UIDynamicAnimator!
    var delegate:SideBarDelegate?
    
   
    override init() {
        super.init()
    }
    
    init(sourceView:UIView, menuItems:Array<String>){
        super.init()
        
        originView                                              = sourceView
        sideBarTableViewController.tableData                    = menuItems
        
        setUpSidebar()
        
        animator                                                = UIDynamicAnimator(referenceView: originView)
        
        let showGestureRecognizer:UISwipeGestureRecognizer      = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
            showGestureRecognizer.direction                     = UISwipeGestureRecognizerDirection.Right

        let hideGestureRecognizer:UISwipeGestureRecognizer      = UISwipeGestureRecognizer(target:self, action: "handleSwipe:")
            hideGestureRecognizer.direction                     = UISwipeGestureRecognizerDirection.Left
        
        originView.addGestureRecognizer(showGestureRecognizer)
        originView.addGestureRecognizer(hideGestureRecognizer)

        
    }

    func setUpSidebar() {
     
        sideBarContainerView.frame                              = CGRect(x: -barWidth-1, y: originView.frame.origin.y, width: barWidth, height: originView.frame.size.height)
        sideBarContainerView.backgroundColor                    = UIColor.clearColor()
        sideBarContainerView.clipsToBounds                      = false
        
        originView.addSubview(sideBarContainerView)
        
        let blurView:UIVisualEffectView                         = UIVisualEffectView(effect: UIBlurEffect(style:UIBlurEffectStyle.Light))
            blurView.frame                                      = sideBarContainerView.bounds
            blurView.contentMode                                = .Bottom
        
        sideBarContainerView.addSubview(blurView)
        
        
        sideBarTableViewController.delegate                     = self
        sideBarTableViewController.tableView.frame              = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds      = false
        sideBarTableViewController.tableView.separatorStyle     = UITableViewCellSeparatorStyle.None
        sideBarTableViewController.tableView.backgroundColor    = UIColor.clearColor()
        sideBarTableViewController.tableView.scrollsToTop       = false

        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
    }
    
    func handleSwipe(recognizer:UISwipeGestureRecognizer){
        if recognizer.direction == UISwipeGestureRecognizerDirection.Left{
            showSideBar(false)
            delegate?.sideBarWillClose?()
        }
        else{
            showSideBar(true)
            delegate?.sideBarWillOpen?()
        }
    }
    
    func showSideBar(shouldOpen:Bool){
        animator.removeAllBehaviors()
        isSideBarOpen = shouldOpen
        
        let gravityX:CGFloat    = (shouldOpen) ? 1 : -1
        let magnitude:CGFloat   = (shouldOpen) ? 20: -20
        let boundaryX:CGFloat   = (shouldOpen) ? barWidth: -barWidth-1
        
        let gravityBehavior:UIGravityBehavior           = UIGravityBehavior (items: [sideBarContainerView])
            gravityBehavior.gravityDirection            = CGVectorMake(gravityX, 0)
        
        let collisionBehavior:UICollisionBehavior       = UICollisionBehavior(items: [sideBarContainerView])
            collisionBehavior.addBoundaryWithIdentifier("sideBarBoundary", fromPoint: CGPointMake(boundaryX, 20), toPoint: CGPointMake(boundaryX, originView.frame.size.height))
        
        let pushBehavior:UIPushBehavior                 = UIPushBehavior(items: [sideBarContainerView], mode: UIPushBehaviorMode.Instantaneous)
            pushBehavior.magnitude                      = magnitude
        
        let sideBarBehavior:UIDynamicItemBehavior       = UIDynamicItemBehavior(items: [sideBarContainerView])
            sideBarBehavior.elasticity                  = 0.1
            sideBarBehavior.friction                    = 0.1
            sideBarBehavior.density                     = 0.2
            sideBarBehavior.resistance                  = 0.2
        
        animator.addBehavior(gravityBehavior)
        animator.addBehavior(collisionBehavior)
        animator.addBehavior(pushBehavior)
        animator.addBehavior(sideBarBehavior)
        
    }
    
    func sideBarControlDidSelectLoad(indexPath: NSIndexPath) {
        delegate?.sideBarDidSelectButtonAtIndex(indexPath.row)
    }


}
