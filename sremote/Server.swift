//
//  Server.swift
//  sremote
//
//  Created by Marc Wilson on 2/14/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import Freddy
import SQLite

class ServerManager {
    var db: Connection
    
    init() {
        self.db = ConnectionManager.instance.get("default")!
    }
    
    func save(server: Server) -> Bool {
        do {
            if let id = server.id {
                if let sort_id = server.sort_id {
                    let stmt = try db.prepare("UPDATE server SET sort_id=?, ip=?, port=?, hostname=?, num_cores=?, num_stopped=?, num_starting=?, num_running=?, num_backoff=?, num_stopping=?, num_exited=?, num_fatal=?, num_unknown=? WHERE id=?")
                    try stmt.run([sort_id, server.ip, server.port, server.hostname, server.num_cores, server.num_stopped,
                        server.num_starting, server.num_running, server.num_backoff, server.num_stopping, server.num_exited, server.num_fatal,
                        server.num_unknown, id])
                }
            } else {
                let stmt = try db.prepare("INSERT INTO server (id, sort_id, ip, port, hostname, num_cores, num_stopped, num_starting, num_running, num_backoff, num_stopping, num_exited, num_fatal, num_unknown) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)")
                let sort_id = Server.servers.count() + 1
                try stmt.run([nil, sort_id, server.ip, server.port, server.hostname, server.num_cores, server.num_stopped,
                    server.num_starting, server.num_running, server.num_backoff, server.num_stopping, server.num_exited, server.num_fatal,
                    server.num_unknown])
                let id = db.lastInsertRowid
                server.sort_id = sort_id
                server.id = id
            }
        } catch {
            print("ServerManager.save ERROR: \(error)")
            return false
        }
        
        return true
    }
    
    func delete(server: Server) -> Bool {
        return true
    }
    
    func all() {
        
    }
    
    func count() -> Int64 {
        return db.scalar("SELECT count(*) FROM server") as! Int64
    }
}

class Server: JSONDecodable, Persist {
    static var servers = ServerManager()
    
    var id: Int64?
    var sort_id: Int64?
    var ip: String?
    var port: String?
    var connection_scheme: String?
    var hostname: String?
    var num_cores: Int?
    
    var num_stopped: Int = 0
    var num_starting: Int = 0
    var num_running: Int = 0
    var num_backoff: Int = 0
    var num_stopping: Int = 0
    var num_exited: Int = 0
    var num_fatal: Int = 0
    var num_unknown: Int = 0
    
    init(id: Int64?, sort_id: Int64?, ip: String, port: String, hostname: String, num_cores: Int,
        num_stopped: Int, num_starting: Int, num_running: Int, num_backoff: Int,
        num_stopping: Int, num_exited: Int, num_fatal: Int, num_unknown: Int) {
        self.id = id
        self.sort_id = sort_id
        self.ip = ip
        self.port = port
        self.hostname = hostname
        self.num_cores = num_cores
        self.num_stopped = num_stopped
        self.num_starting = num_starting
        self.num_running = num_running
        self.num_backoff = num_backoff
        self.num_stopping = num_stopping
        self.num_exited = num_exited
        self.num_fatal = num_fatal
        self.num_unknown = num_unknown
    }
    
    required init(json value: JSON) throws {
        // Missing id, sort_id, ip, and port number
        self.hostname = try value.string("hostname")
        self.num_cores = try value.int("num_cores")
        
        self.num_stopped = 0
        self.num_starting = 0
        self.num_running = 0
        self.num_backoff = 0
        self.num_stopping = 0
        self.num_exited = 0
        self.num_fatal = 0
        self.num_unknown = 0
        
        for val in try value.array("processes") {
            switch try val.int("state") {
            case Constants.ProcessStates.BACKOFF:
                self.num_backoff += 1
                break
            case Constants.ProcessStates.EXITED:
                self.num_exited += 1
                break
            case Constants.ProcessStates.FATAL:
                self.num_fatal += 1
                break
            case Constants.ProcessStates.RUNNING:
                self.num_running += 1
                break
            case Constants.ProcessStates.STARTING:
                self.num_starting += 1
                break
            case Constants.ProcessStates.STOPPED:
                self.num_stopped += 1
                break
            case Constants.ProcessStates.STOPPING:
                self.num_stopping += 1
                break
            case Constants.ProcessStates.UNKNOWN:
                self.num_unknown += 1
                break
            default:
                break
            }
        }
    }
    
    func save() -> Bool {
        return Server.servers.save(self)
    }
    
    func delete() -> Bool {
        return Server.servers.delete(self)
    }
    
    static func migrate(db:Connection, direction: Migrations.Direction) {
        switch direction {
        case Migrations.Direction.Up:
            do {
                let table_exists_stmt = try db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name=?") //, ["server"])
                if let row = table_exists_stmt.scalar(["server"]) {
                    print("Table '\(row)' exists.")
                } else {
                    // Table 'server' doesn't exist. So create it.
                    let stmt = try db.prepare("CREATE TABLE server (id INTEGER PRIMARY KEY AUTOINCREMENT, sort_id INTEGER, ip TEXT, port INTEGER, hostname TEXT, num_cores INTEGER, num_stopped INTEGER, num_starting INTEGER, num_running INTEGER, num_backoff INTEGER, num_stopping INTEGER, num_exited INTEGER, num_fatal INTEGER, num_unknown INTEGER, created TIMESTAMP, UNIQUE(sort_id), UNIQUE(ip, port))")
                    try stmt.run()
                }
            } catch {
                print("caught: \(error)")
                print("Error creating 'server' table.")
            }
            break
        case Migrations.Direction.Down:
            do {
                let stmt = try db.prepare("DROP TABLE server")
                try stmt.run()
            } catch {
                print("caught: \(error)")
                print("Error dropping 'server' table.")
            }
        }
    }
    
    func processes() -> [ProcessData] {
        return []
    }
}