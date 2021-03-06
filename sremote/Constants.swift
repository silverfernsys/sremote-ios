//
//  Constants.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/29/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

struct Constants {
    struct Theme {
        static let LIGHT = 0
        static let DARK = 1
    }
    struct UpdateFrequency {
        static let MINUTE = 0
        static let FIVE_MINUTES = 1
        static let TEN_MINUTES = 2
        static let FIFTEEN_MINUTES = 3
        static let THIRTY_MINUTES = 4
        static let HOUR = 5
    }
    
    struct ServerEntryViewController {
        static let Loaded = "ServerEntryViewController.Loaded"
        static let ServerAdded = "ServerEntryViewController.ServerAdded"
    }
    
    struct ServerListViewController {
        static let DeleteServer = "ServerListViewController.DeleteServer"
    }
    
    struct ProcessStates {
        static let STOPPED = 0
        static let STARTING = 10
        static let RUNNING = 20
        static let BACKOFF = 30
        static let STOPPING = 40
        static let EXITED = 100
        static let FATAL = 200
        static let UNKNOWN = 1000
    }
    
    struct ProcessStateColors {
        static let STOPPED = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        static let STARTING = UIColor(red: 0, green: 127 / 256, blue: 255 / 256, alpha: 0.5)
        static let RUNNING = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
        static let BACKOFF = UIColor(red: 0, green: 1, blue: 1, alpha: 0.5)
        static let STOPPING = UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.5)
        static let EXITED = UIColor(red: 1, green: 0, blue: 1, alpha: 0.5)
        static let FATAL = UIColor(red: (153.0 / 255.0), green: (50.0 / 255.0), blue: (204.0 / 255.0), alpha: 0.5)
        static let UNKNOWN = UIColor(red: (190.0 / 255.0), green: (190.0 / 255.0), blue: (190.0 / 255.0), alpha: 0.5)
    }
    
    struct ConnectionScheme {
        static let HTTP = "HTTP"
        static let HTTPS = "HTTPS"
    }
}