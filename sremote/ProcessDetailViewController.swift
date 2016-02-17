//
//  ProcessDetailViewController.swift
//  sremote
//
//  Created by Marc Wilson on 2/17/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

class ProcessDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProcessDetailViewController.viewDidLoad")
        theme()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func theme() {
        dispatch_async(dispatch_get_main_queue(), {
            let theme = ThemeFactory.sharedInstance().theme
            theme.styleViewController(self)
        })
    }
}


