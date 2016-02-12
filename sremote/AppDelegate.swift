//
//  AppDelegate.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/20/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import Starscream

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WebSocketDelegate {

    var window: UIWindow?
    var serverEntryViewController: ServerEntryViewController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSeverEntryViewControllerLoad:", name: Constants.ServerEntryViewController.Loaded, object: nil)
        let socket = WebSocket(url: NSURL(string: "ws://localhost:8080/")!)
        socket.delegate = self
        socket.connect()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        serverEntryViewController?.performSegueWithIdentifier("HideServerEntry", sender: self)
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        theme()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func websocketDidConnect(socket: WebSocket) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("websocket is disconnected: \(error?.localizedDescription)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("got some text: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        print("got some data: \(data.length)")
    }
    
    func websocketDidReceivePong(socket: WebSocket) {
        print("Got pong!")
    }
    
    func handleSeverEntryViewControllerLoad(notification: NSNotification) {
        serverEntryViewController = notification.object as? ServerEntryViewController
        serverEntryViewController?.hello()
    }
    
    func theme() {
        dispatch_async(dispatch_get_main_queue(), {
            let defaults = NSUserDefaults.standardUserDefaults()
            let theme_preference = defaults.integerForKey("theme_preference")
            
            let theme: Theme = ThemeFactory.sharedInstance().themeWithPreference(theme_preference)
            theme.styleNavigationController(self.window?.rootViewController as! UINavigationController)
            theme.styleTableViewController((self.window?.rootViewController as! UINavigationController).viewControllers.first as! UITableViewController)
        })
    }
}