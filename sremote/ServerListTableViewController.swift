//
//  ServerListTableViewController.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/20/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import PKHUD

class ServerListTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    var servers:[Server] = serverData
    
    let landscapeHeight:CGFloat = 100.0
    let portraitHeight:CGFloat = 144.0
    
    // For reordering cells
    var snapshot: UIView? = nil
    var sourceIndexPath: NSIndexPath? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        style()
        if (servers.count == 0) {
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("ShowServerEntry", sender: self)
            }
        }
        
        // http://www.raywenderlich.com/63089/cookbook-moving-table-view-cells-with-a-long-press-gesture
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("handleLongPress:"))
        tableView.addGestureRecognizer(longPress)
        
//        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
//        tableView.addGestureRecognizer(tap)
//        
        let deleteRightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleDeleteSwipe:"))
        deleteRightSwipe.direction = .Right
        tableView.addGestureRecognizer(deleteRightSwipe)
        
        let deleteLeftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleDeleteSwipe:"))
        deleteLeftSwipe.direction = .Left
        tableView.addGestureRecognizer(deleteLeftSwipe)
        
        deleteRightSwipe.delegate = self
        deleteLeftSwipe.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleServerDelete:", name: Constants.ServerListViewController.DeleteServer, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSeverEntryViewControllerServerAdded:", name: Constants.ServerEntryViewController.ServerAdded, object: nil)
        self.tableView.delegate = self
    }
    
    func handleServerDelete(notitification: NSNotification) {
        let alertController = UIAlertController(title: "Delete Server", message: "Are you sure you want to delete this server?", preferredStyle: UIAlertControllerStyle.Alert)
        let deleteAction = UIAlertAction(title: "Delete", style:UIAlertActionStyle.Destructive) { (action) in
            let cell = notitification.object as! ServerCell
            cell.hideDelete(true)
            let indexPath = self.tableView.indexPathForCell(cell)
            let server = self.servers[indexPath!.row]
            self.servers.removeAtIndex(indexPath!.row)
            server.delete()
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) in })
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true) { }
    }
    
    func handleSeverEntryViewControllerServerAdded(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        print("handleTap")
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer) {
        let longPress: UILongPressGestureRecognizer = sender;
        let state: UIGestureRecognizerState = longPress.state
        
        let location: CGPoint = longPress.locationInView(self.tableView)
        let indexPath: NSIndexPath = tableView.indexPathForRowAtPoint(location)!
        switch state {
        case UIGestureRecognizerState.Possible:
            let cell: ServerCell = self.tableView.cellForRowAtIndexPath(indexPath)! as! ServerCell
            cell.hideDelete(false)
            break
        case UIGestureRecognizerState.Began:
            sourceIndexPath = indexPath
            let cell: ServerCell = self.tableView.cellForRowAtIndexPath(indexPath)! as! ServerCell
            cell.hideDelete(false)
            snapshot = customSnapshotFromView(cell)
            var center: CGPoint = cell.center
            snapshot?.center = center
            snapshot?.alpha = 0.0
            self.tableView.addSubview(snapshot!)
            UIView.animateWithDuration(0.25, animations: {
                
                // Offset for gesture location
                center.y = location.y
                self.snapshot?.center = center
                self.snapshot?.transform = CGAffineTransformMakeScale(1.05, 1.05)
                self.snapshot?.alpha = 0.98
                
                // Fade out
                cell.alpha = 0.0
                
                }, completion: { (finished) in
                    cell.hidden = true
            })
            break
        case UIGestureRecognizerState.Changed:
            var center: CGPoint? = snapshot?.center
            center?.y = location.y
            snapshot?.center = center!
            
            if (!indexPath.isEqual(sourceIndexPath)) {
                // ... update data source.
                // [self.objects exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                // ... move the rows.
                self.tableView.moveRowAtIndexPath(sourceIndexPath!, toIndexPath: indexPath)
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath
            }
            break
        default:
            let cell: UITableViewCell = self.tableView.cellForRowAtIndexPath(sourceIndexPath!)!
            cell.hidden = false
            cell.alpha = 0.0
            UIView.animateWithDuration(0.25, animations: {
                self.snapshot?.center = cell.center
                self.snapshot?.transform = CGAffineTransformIdentity
                self.snapshot?.alpha = 0.0
                cell.alpha = 1.0
                }, completion: { (finish) in
                    self.sourceIndexPath = nil
                    self.snapshot?.removeFromSuperview()
                    self.snapshot = nil
                    cell.hidden = false
                    cell.alpha = 1.0
            })
            break
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    func handleDeleteSwipe(sender:UISwipeGestureRecognizer) {
        print("frame: \(self.tableView.frame)")
        let location: CGPoint = sender.locationInView(self.tableView)
        let indexPath: NSIndexPath = tableView.indexPathForRowAtPoint(location)!
        let cell : ServerCell = self.tableView.cellForRowAtIndexPath(indexPath) as! ServerCell
        
        if sender.direction == .Right {
            cell.showDelete()
        } else {
            cell.hideDelete(true)
        }
    }
    
    func customSnapshotFromView(view: UIView) -> UIView {
        // Make an image from the input view.
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0);
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Create an image view.
        let snapshot: UIView = UIImageView(image: image)
        snapshot.layer.masksToBounds = false;
        snapshot.layer.cornerRadius = 0.0;
        snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
        snapshot.layer.shadowRadius = 5.0;
        snapshot.layer.shadowOpacity = 0.4;
        
        return snapshot
    }
    
    func style() {
        self.tableView.separatorStyle = .SingleLine
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.layoutMargins = UIEdgeInsetsZero
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        ServerCell.appearance().layoutMargins = UIEdgeInsetsZero
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        // This controller's view takes up the entire screen, so
        // size.width > size.height: landscape.
        // size.height > size.width: portrait.
        if size.height > size.width {
            let cellSize = CGSize(width: size.width, height: portraitHeight)
            for cell in self.tableView.visibleCells as! [ServerCell] {
                cell.layoutPortrait(cellSize)
            }
        } else {
            let cellSize = CGSize(width: size.width, height: landscapeHeight)
            for cell in self.tableView.visibleCells as! [ServerCell] {
                cell.layoutLandscape(cellSize)
            }
        }
    }

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //if UIDevice.currentDevice().orientation.isLandscape.boolValue {
        if isLandscape() {
            return landscapeHeight
        } else {
            return portraitHeight
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelToServerListViewController(segue:UIStoryboardSegue) {
        
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ServerCell", forIndexPath: indexPath) as! ServerCell
        let server = servers[indexPath.row] as Server
        cell.server = server
        
        //if UIDevice.currentDevice().orientation.isLandscape.boolValue {
        if isLandscape() {
            cell.layoutLandscape(CGSize(width: self.tableView.frame.size.width, height: landscapeHeight))
        } else {
            cell.layoutPortrait(CGSize(width: self.tableView.frame.size.width, height: portraitHeight))
        }
        
        cell.theme()
        return cell
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath")
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("willSelectRowAtIndexPath")
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ServerCell
        cell.hideDelete(false)
        return indexPath
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInView(self.view)
            let indexPath: NSIndexPath = tableView.indexPathForRowAtPoint(location)!
            let cell : ServerCell = self.tableView.cellForRowAtIndexPath(indexPath) as! ServerCell
            cell.hideDelete(false)
            // do something with your currentPoint
        }
    }
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch = touches.first {
//            let currentPoint = touch.locationInView(self.tableView)
//            // do something with your currentPoint
//        }
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch = touches.first {
//            let currentPoint = touch.locationInView(self.tableView)
//            // do something with your currentPoint
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowProcessList" {
            print("prepareForSegue")
            let processTableViewController = segue.destinationViewController as! ProcessTableViewController
            processTableViewController.processes = processData
        }
    }
}
