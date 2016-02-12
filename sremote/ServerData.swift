//
//  ServerData.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/27/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

struct ServerData {
    var ip: String?
    var port: String?
    var stats: Dictionary<String, Int>?
    
    init(ip: String, port: String, stats: Dictionary<String, Int>) {
        self.ip = ip
        self.port = port
        self.stats = stats
    }
}