//
//  ServerEntryViewController.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/20/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import Freddy

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
        var str = NSAttributedString(string: "address", attributes: [NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        serverNameLabel.attributedPlaceholder = str
        
        serverPortLabel.autocapitalizationType = UITextAutocapitalizationType.None
        serverPortLabel.autocorrectionType = UITextAutocorrectionType.No
        serverPortLabel.keyboardType = UIKeyboardType.NumberPad
        str = NSAttributedString(string: "port", attributes: [NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        serverPortLabel.attributedPlaceholder = str
        
        usernameLabel.autocapitalizationType = UITextAutocapitalizationType.None
        usernameLabel.autocorrectionType = UITextAutocorrectionType.No
        usernameLabel.keyboardType = UIKeyboardType.Default
        str = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        usernameLabel.attributedPlaceholder = str
        
        passwordLabel.autocapitalizationType = UITextAutocapitalizationType.None
        passwordLabel.autocorrectionType = UITextAutocorrectionType.No
        passwordLabel.keyboardType = UIKeyboardType.Default
        passwordLabel.secureTextEntry = true
        str = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        passwordLabel.attributedPlaceholder = str
        
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.ServerEntryViewController.Loaded, object: self)
        positionLables()
    }
    
    func positionLabel(label: UITextField) {
        label.frame = CGRectMake(label.frame.origin.x,
            label.frame.origin.y, self.view.frame.width - (2.0 * label.frame.origin.x), label.frame.size.height)
    }
    
    func positionLables() {
        positionLabel(serverNameLabel)
        positionLabel(serverPortLabel)
        positionLabel(usernameLabel)
        positionLabel(passwordLabel)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        positionLables()
    }

    func hello() -> Void {
        print("Hello from ServerEntryViewController!")
    }
    
    @IBAction func handleSave(sender: UIButton) {
        print("handleSave")
        let serverName = serverNameLabel.text!
        let serverPort = serverPortLabel.text!
        let username = usernameLabel.text
        let password = passwordLabel.text
        
        let url = NSURL(string: "http://\(serverName):\(serverPort)/")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            print("data: \(data)")
            print("response: \(response)")
            print("error: \(error)")
            
            do {
                let json = try JSON(data: data!)
                let version = try json.double("version")
                print("version: \(version)")
                
                // Now try signing in!
                let tokenUrl = NSURL(string: "http://\(serverName):\(serverPort)/token/")
                let tokenRequest = NSMutableURLRequest(URL: tokenUrl!)
                tokenRequest.setValue(username, forHTTPHeaderField: "username")
                tokenRequest.setValue(password, forHTTPHeaderField: "password")

                let signInTask = NSURLSession.sharedSession().dataTaskWithRequest(tokenRequest) { (data, response, error) in
                    do {
                        let tokenJson = try JSON(data: data!)
                        let token = try tokenJson.string("token")
                        print("token: \(token)")
                        self.performSegueWithIdentifier("hideServerEntry", sender: nil)
                    } catch {
                        
                    }
                }
                signInTask.resume()
            } catch {
//                 do something with the error
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
