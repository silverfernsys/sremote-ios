//
//  ProcessData.swift
//  sremote
//
//  Created by Marc Wilson on 2/15/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//
import UIKit
import Freddy
import SQLite

class ProcessManager {
    init() {
        
    }
    
    func all() {
        
    }
}

class ProcessData: JSONDecodable {
    static var processes = ProcessManager()
    
    var id: Int?
    var sort_id: Int?
    var group: String
    var name: String
    var pid: Int?
    var state: Int
    var start: Double?
    var cpu: [[Double]]?
    var memory: [[Double]]?
    var server: Server?
    
    init(id: Int, sort_id: Int, group: String, name: String, pid: Int, state: Int,
        start: Double, cpu:[[Double]], memory:[[Double]], server: Server) {
            self.id = id
            self.sort_id = sort_id
            self.group = group
            self.name = name
            self.pid = pid
            self.state = state
            self.start = start
            self.cpu = cpu
            self.memory = memory
            self.server = server
    }
    
    required init(json value: JSON) throws {
        // Missing id, sort_id
        self.group = "group"
        self.name = "name"
        self.pid = -1
        self.state = Constants.ProcessStates.UNKNOWN
        self.start = 0.0
        
        self.group = try value.string("group")
        self.name = try value.string("name")
        self.pid = try value.int("pid")
        self.state = try value.int("state")
        self.start = try value.double("start")
        self.cpu = try value.array("cpu").map(parse_time_series_array)
        self.memory = try value.array("mem").map(parse_time_series_array)
    }
    
    func parse_time_series_array(json value: JSON) throws -> [Double] {
        print("value: \(value)")
        return [1.0, 0.0]
    }
    
    func save() -> Bool {
        // Persist to database and populate id and sort_id fields
        return true
    }
}