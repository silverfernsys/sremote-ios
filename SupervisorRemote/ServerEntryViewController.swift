//
//  ServerEntryViewController.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/20/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import PKHUD

class ServerEntryViewController: UITableViewController {

    @IBOutlet weak var serverNameLabel: UITextField!
    @IBOutlet weak var serverPortLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ServerEntryViewController.viewDidLoad()")
        
        serverNameLabel.autocapitalizationType = UITextAutocapitalizationType.None
        serverNameLabel.autocorrectionType = UITextAutocorrectionType.No
        serverNameLabel.keyboardType = UIKeyboardType.Default
        
        serverPortLabel.autocapitalizationType = UITextAutocapitalizationType.None
        serverPortLabel.autocorrectionType = UITextAutocorrectionType.No
        serverPortLabel.keyboardType = UIKeyboardType.NumberPad
        
        usernameLabel.autocapitalizationType = UITextAutocapitalizationType.None
        usernameLabel.autocorrectionType = UITextAutocorrectionType.No
        serverNameLabel.keyboardType = UIKeyboardType.Default
        
        passwordLabel.autocapitalizationType = UITextAutocapitalizationType.None
        passwordLabel.autocorrectionType = UITextAutocorrectionType.No
        serverNameLabel.keyboardType = UIKeyboardType.Default
        passwordLabel.secureTextEntry = true
        
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.ServerEntryViewController.Loaded, object: self)
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            PKHUD.sharedHUD.contentView = PKHUDSuccessView()
            PKHUD.sharedHUD.hide(afterDelay: 2.0)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func hello() -> Void {
        print("Hello from ServerEntryViewController!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
