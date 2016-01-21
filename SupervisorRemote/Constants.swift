//
//  Constants.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/29/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import Foundation

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
    }
}