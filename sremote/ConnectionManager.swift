//
//  ConnectionManager.swift
//  sremote
//
//  Created by Marc Wilson on 2/15/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import SQLite

class ConnectionManager {
    static var instance = ConnectionManager()
    var connections = Dictionary<String, Connection>()
    
    init() {
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let path = (documents as NSString).stringByAppendingPathComponent("db.sqlite")
        do {
            let db = try Connection(path)
            connections["default"] = db
        } catch {
            print("ConnectionManager.init ERROR: \(error)")
        }
    }
    
    func get(name: String) -> Connection? {
        return connections[name]
    }
    
    func add(name: String, db: Connection) {
        connections[name] = db
    }
}