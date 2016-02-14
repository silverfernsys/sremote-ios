//
//  ServerEntryViewController.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/20/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import Freddy

class ServerEntryViewController: UITableViewController, UITextFieldDelegate {

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
        
        serverNameLabel.delegate = self
        serverPortLabel.delegate = self
        usernameLabel.delegate = self
        passwordLabel.delegate = self
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
    
    func showAlert(message:String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let okAction = UIAlertAction(title: "OK", style:UIAlertActionStyle.Destructive) { (action) in }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true) { }
    }
    
    func showConnectionAlert() {
        let alertController = UIAlertController(title: "Connecting to server...", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alertController, animated: true) { }
    }
    
    func showConnectionErrorAlert() {
        let alertController = UIAlertController(title: "Could not connect to server", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style:UIAlertActionStyle.Destructive) { (action) in }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true) { }
    }
    
    func showServerConfigErrorAlert() {
        let alertController = UIAlertController(title: "Server not configured", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style:UIAlertActionStyle.Destructive) { (action) in }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true) { }
    }
    
    func showAuthenticationErrorAlert() {
        let alertController = UIAlertController(title: "Authentication failed", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style:UIAlertActionStyle.Destructive) { (action) in }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true) { }
    }
    
    func connect(server:String, port:String, username:String, password:String) {
        let url = NSURL(string: "http://\(server):\(port)/")
        showConnectionAlert()
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil {
                print("error: \(error)")
                dispatch_async(dispatch_get_main_queue(),{
                    self.dismissViewControllerAnimated(false, completion: {
                        self.showConnectionErrorAlert()
                    })
                })
            } else {
                print("data: \(data)")
                print("response: \(response)")
                do {
                    let json = try JSON(data: data!)
                    let version = try json.double("version")
                    print("version: \(version)")
                    
                    // Now try signing in!
                    let tokenUrl = NSURL(string: "http://\(server):\(port)/token/")
                    let tokenRequest = NSMutableURLRequest(URL: tokenUrl!)
                    tokenRequest.setValue(username, forHTTPHeaderField: "username")
                    tokenRequest.setValue(password, forHTTPHeaderField: "password")
                    
                    let signInTask = NSURLSession.sharedSession().dataTaskWithRequest(tokenRequest) { (data, response, error) in
                        if error != nil {
                            print("error: \(error)")
                            dispatch_async(dispatch_get_main_queue(),{
                                self.dismissViewControllerAnimated(false, completion: {
                                    self.showAuthenticationErrorAlert()
                                })
                            })
                        } else {
                            do {
                                let tokenJson = try JSON(data: data!)
                                let token = try tokenJson.string("token")
                                print("token: \(token)")
                                self.performSegueWithIdentifier("hideServerEntry", sender: nil)
                            } catch {
                                dispatch_async(dispatch_get_main_queue(),{
                                    self.dismissViewControllerAnimated(false, completion: {
                                        self.showAuthenticationErrorAlert()
                                    })
                                })
                            }
                        }
                    }
                    signInTask.resume()
                } catch {
                    dispatch_async(dispatch_get_main_queue(),{
                        self.dismissViewControllerAnimated(false, completion: {
                            self.showServerConfigErrorAlert()
                        })
                    })
                }
            }
        }
        task.resume()
    }
    
    @IBAction func handleSave(sender: UIButton) {
        print("handleSave")
        var shouldShowAlert = false
        var alertMessage = ""
        
        if serverNameLabel.text!.isEmpty {
            shouldShowAlert = true
            alertMessage = "Missing server address"
        } else if serverPortLabel.text!.isEmpty {
            shouldShowAlert = true
            alertMessage = "Missing port number"
        } else if usernameLabel.text!.isEmpty {
            shouldShowAlert = true
            alertMessage = "Missing username"
        } else if passwordLabel.text!.isEmpty {
            shouldShowAlert = true
            alertMessage = "Missing password"
        }
        
        if shouldShowAlert {
            showAlert(alertMessage)
        } else {
            connect(serverNameLabel.text!,
                port: serverPortLabel.text!,
                username: usernameLabel.text!,
                password: passwordLabel.text!)
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.textColor = ThemeFactory.sharedInstance().theme.cellPrimaryTextColor()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}