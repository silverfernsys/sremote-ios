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
    var db: Connection
    
    init() {
        self.db = ConnectionManager.instance.get("default")!
    }
    
    func save(process: Process) -> Bool {
        do {
            if let id = process.id {
                guard let sort_id = process.sort_id else { return false }
                guard let server_id = process.server_id else { return false }
                let stmt = try db.prepare("UPDATE process SET server_id=?, sort_id=?, groupname=?, name=?, pid=?, state=?, start=? WHERE id=?")
                try stmt.run([server_id, sort_id, process.group, process.name, process.pid, process.state, process.start, id])
            } else {
                guard let server_id = process.server_id else { return false }
                let stmt = try db.prepare("INSERT INTO process (id, server_id, sort_id, groupname, name, pid, state, start) VALUES (?,?,?,?,?,?,?,?)")
                let sort_id = Process.processes.count(server_id) + 1 // ******** BUG ********** should be filtering count by server_id
                try stmt.run([nil, server_id, sort_id, process.group, process.name, process.pid, process.state, process.start])
                let id = db.lastInsertRowid
                process.sort_id = sort_id
                process.id = id
            }
        } catch {
            print("ProcessManager.save ERROR: \(error)")
            return false
        }
        
        return true
    }
    
    func delete(server: Process) -> Bool {
        if let id = server.id {
            do {
                let stmt = try db.prepare("DELETE FROM process WHERE id=?")
                try stmt.run([id])
                return true
            } catch {
                print("ProcessManager.delete ERROR: \(error)")
                return false
            }
        } else {
            return false
        }
    }
    
    func filter(server_id: Int64) -> [Process] {
        var results = [Process]()
        
        do {
            for row in try db.prepare("SELECT * FROM process WHERE server_id=?", [server_id]) {
                let id = row[0] as! Int64
                let server_id = row[1] as! Int64
                let sort_id = row[2] as! Int64
                let group = row[3] as! String
                let name = row[4] as! String
                let pid = row[5] as! Int64
                let state = row[6] as! Int64
                let start = row[7] as! Double
                let process = Process(id: id, sort_id: sort_id, group: group, name: name, pid: pid, state: state, start: start, cpu: nil, memory: nil, server_id: server_id)
                results.append(process)
            }
        } catch {
            print("ProcessManager.all() ERROR: \(error)")
        }
        
        return results
    }
    
    func all() -> [Process] {
        var results = [Process]()
        
        do {
            for row in try db.prepare("SELECT * FROM process") {
                let id = row[0] as! Int64
                let server_id = row[1] as! Int64
                let sort_id = row[2] as! Int64
                let group = row[3] as! String
                let name = row[4] as! String
                let pid = row[5] as! Int64
                let state = row[6] as! Int64
                let start = row[7] as! Double
                let process = Process(id: id, sort_id: sort_id, group: group, name: name, pid: pid, state: state, start: start, cpu: nil, memory: nil, server_id: server_id)
                results.append(process)
            }
        } catch {
            print("ProcessManager.all() ERROR: \(error)")
        }
        
        return results
    }
    
    func count() -> Int64 {
        return db.scalar("SELECT count(*) FROM process") as! Int64
    }
    
    func count(server_id: Int64) -> Int64 {
        return db.scalar("SELECT count(*) FROM process WHERE server_id=?", [server_id]) as! Int64
    }
}

class Process: JSONDecodable, CustomStringConvertible {
    static var processes = ProcessManager()
    
    var id: Int64?
    var sort_id: Int64?
    var group: String
    var name: String
    var pid: Int64?
    var state: Int64
    var start: Double?
    var cpu: [[Double]]?
    var memory: [[Double]]?
    var server_id: Int64?
    
    var server: Server {
        get {
            return Server.servers.get(server_id!)!
        }
        set(val) {
            self.server_id = val.id
        }
    }
    
    init(id: Int64?, sort_id: Int64?, group: String, name: String, pid: Int64, state: Int64,
        start: Double, cpu:[[Double]]?, memory:[[Double]]?, server_id: Int64) {
            self.id = id
            self.sort_id = sort_id
            self.group = group
            self.name = name
            self.pid = pid
            self.state = state
            self.start = start
            self.cpu = cpu
            self.memory = memory
            self.server_id = server_id
    }
    
    required init(json value: JSON) throws {
        // Missing id, sort_id
        self.group = "group"
        self.name = "name"
        self.pid = -1
        self.state = Int64(Constants.ProcessStates.UNKNOWN)
        self.start = 0.0
        
        self.group = try value.string("group")
        self.name = try value.string("name")
        self.pid = Int64(try value.int("pid"))
        self.state = Int64(try value.int("state"))
        self.start = try value.double("start")
        self.cpu = try value.array("cpu").map(parse_time_series_array)
        self.memory = try value.array("mem").map(parse_time_series_array)
    }
    
    func parse_time_series_array(json value: JSON) throws -> [Double] {
        print("value: \(value)")
        return [1.0, 0.0]
    }
    
    func save() -> Bool {
        return Process.processes.save(self)
    }
    
    func delete() -> Bool {
        return Process.processes.delete(self)
    }
    
    static func migrate(db:Connection, direction: Migrations.Direction) {
        switch direction {
        case Migrations.Direction.Up:
            do {
                let table_exists_stmt = try db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name=?")
                if let row = table_exists_stmt.scalar(["process"]) {
                    print("Table '\(row)' exists.")
                } else {
                    // Table 'server' doesn't exist. So create it.
                    let stmt = try db.prepare("CREATE TABLE process (id INTEGER PRIMARY KEY AUTOINCREMENT, server_id INTEGER, sort_id INTEGER, groupname TEXT, name TEXT, pid INTEGER, state INTEGER, start TIMESTAMP, UNIQUE(server_id, groupname, name))")
                    try stmt.run()
                    // Create databases for cpu and mem usage.
                    // These will be named <server_id>_<group>_<name>/cpu.sqlite and <server_id>_<group>_<name>/mem.sqlite
                }
            } catch {
                print("caught: \(error)")
                print("Error creating 'process' table.")
            }
            break
        case Migrations.Direction.Down:
            do {
                let stmt = try db.prepare("DROP TABLE process")
                try stmt.run()
            } catch {
                print("caught: \(error)")
                print("Error dropping 'process' table.")
            }
        }
    }
    
    var description: String {
        get {
            return "<Process: id: \(self.id!), sort_id: \(self.sort_id!), server_id: \(self.server_id!), group: \(self.group), name: \(self.name), pid: \(self.pid!), state: \(self.state), start: \(self.start!), cpu: \(self.cpu), mem: \(self.memory)>"
        }
    }
}