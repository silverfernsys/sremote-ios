//
//  ServerListTableViewController.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/20/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

class ServerListTableViewController: UITableViewController {
    var servers:[ServerData] = serverData
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        theme()
        if (servers.count == 0) {
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("ShowServerEntry", sender: self)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        theme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelToServerListViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveServerEntry(segue:UIStoryboardSegue) {
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return servers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ServerCell", forIndexPath: indexPath) as! ServerCell
        let server = servers[indexPath.row] as ServerData
        cell.server = server

        // Configure the cell...

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func theme() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let theme_preference = defaults.integerForKey("theme_preference")
        
        if (theme_preference == Constants.Theme.LIGHT) {
            lightTheme()
        } else {
            darkTheme()
        }
        
        self.view.setNeedsDisplay()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.setNeedsDisplay()
        self.navigationController?.navigationController?.setNeedsStatusBarAppearanceUpdate()
//        let nv = self.navigationController?.navigationBar
        
        print(theme_preference)
    }
    
    func darkTheme() {
        let tableViewCellAppearance: UITableViewCell = UITableViewCell.appearance()
        tableViewCellAppearance.backgroundColor = UIColor.extraDarkGrey()
        
        let tableViewAppearance: UITableView = UITableView.appearance()
        tableViewAppearance.backgroundColor = UIColor.extraDarkGrey()
        
        let navigationBarAppearance: UINavigationBar = UINavigationBar.appearance()
        navigationBarAppearance.barStyle = UIBarStyle.BlackTranslucent
    }
    
    func lightTheme() {
        let tableViewCellAppearance: UITableViewCell = UITableViewCell.appearance()
        tableViewCellAppearance.backgroundColor = UIColor.whiteColor()
        
        let tableViewAppearance: UITableView = UITableView.appearance()
        tableViewAppearance.backgroundColor = UIColor.whiteColor()
        
        let navigationBarAppearance: UINavigationBar = UINavigationBar.appearance()
        navigationBarAppearance.barStyle = UIBarStyle.Default
    }
}
