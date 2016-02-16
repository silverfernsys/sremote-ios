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
                    let stmt = try db.prepare("UPDATE server SET sort_id=?, ip=?, port=?, hostname=?, connection_scheme=?, num_cores=?, num_stopped=?, num_starting=?, num_running=?, num_backoff=?, num_stopping=?, num_exited=?, num_fatal=?, num_unknown=? WHERE id=?")
                    try stmt.run([sort_id, server.ip, server.port, server.hostname, server.connection_scheme, server.num_cores, server.num_stopped,
                        server.num_starting, server.num_running, server.num_backoff, server.num_stopping, server.num_exited, server.num_fatal,
                        server.num_unknown, id])
                } else {
                    return false
                }
            } else {
                let stmt = try db.prepare("INSERT INTO server (id, sort_id, ip, port, hostname, connection_scheme, num_cores, num_stopped, num_starting, num_running, num_backoff, num_stopping, num_exited, num_fatal, num_unknown) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)")
                let sort_id = Server.servers.count() + 1
                try stmt.run([nil, sort_id, server.ip, server.port, server.hostname, server.connection_scheme, server.num_cores, server.num_stopped,
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
        if let id = server.id {
            do {
                let stmt = try db.prepare("DELETE FROM server WHERE id=?")
                try stmt.run([id])
                return true
            } catch {
                print("ServerManager.delete ERROR: \(error)")
                return false
            }
        } else {
            return false
        }
    }
    
    func processes(server: Server) -> [Process] {
        if let id = server.id {
            return Process.processes.filter(id)
        } else {
            return [Process]()
        }
    }
    
    func get(id: Int64) -> Server? {
        do {
            for row in try db.prepare("SELECT * FROM server WHERE id=?", [id]).run() {
                let id = row[0] as! Int64
                let sort_id = row[1] as! Int64
                let ip = row[2] as! String
                let port = row[3] as! Int64
                let hostname = row[4] as! String
                let connection_scheme = row[5] as! String
                let num_cores = row[6] as! Int64
                
                let num_stopped = row[7] as! Int64
                let num_starting = row[8] as! Int64
                let num_running = row[9] as! Int64
                let num_backoff = row[10] as! Int64
                let num_stopping = row[11] as! Int64
                let num_exited = row[12] as! Int64
                let num_fatal = row[13] as! Int64
                let num_unknown = row[14] as! Int64
                
                return Server(id: id, sort_id: sort_id, ip: ip, port: port, hostname: hostname, connection_scheme: connection_scheme, num_cores: num_cores, num_stopped: num_stopped, num_starting: num_starting, num_running: num_running, num_backoff: num_backoff, num_stopping: num_stopping, num_exited: num_exited, num_fatal: num_fatal, num_unknown: num_unknown)
            }
        } catch {
            print("ServerManager.all() ERROR: \(error)")
            return nil
        }
        
        return nil
    }
    
    func all() -> [Server] {
        var results = [Server]()
        
        do {
            for row in try db.prepare("SELECT * FROM server") {
                let id = row[0] as! Int64
                let sort_id = row[1] as! Int64
                let ip = row[2] as! String
                let port = row[3] as! Int64
                let hostname = row[4] as! String
                let connection_scheme = row[5] as! String
                let num_cores = row[6] as! Int64
                
                let num_stopped = row[7] as! Int64
                let num_starting = row[8] as! Int64
                let num_running = row[9] as! Int64
                let num_backoff = row[10] as! Int64
                let num_stopping = row[11] as! Int64
                let num_exited = row[12] as! Int64
                let num_fatal = row[13] as! Int64
                let num_unknown = row[14] as! Int64
                
                let server = Server(id: id, sort_id: sort_id, ip: ip, port: port, hostname: hostname, connection_scheme: connection_scheme, num_cores: num_cores, num_stopped: num_stopped, num_starting: num_starting, num_running: num_running, num_backoff: num_backoff, num_stopping: num_stopping, num_exited: num_exited, num_fatal: num_fatal, num_unknown: num_unknown)
                results.append(server)
            }
        } catch {
            print("ServerManager.all() ERROR: \(error)")
        }
        
        return results
    }
    
    func count() -> Int64 {
        return db.scalar("SELECT count(*) FROM server") as! Int64
    }
}

class Server: JSONDecodable, Persist, CustomStringConvertible {
    static var servers = ServerManager()
    
    var id: Int64?
    var sort_id: Int64?
    var ip: String?
    var port: Int64?
    var connection_scheme: String?
    var hostname: String?
    var num_cores: Int64?
    
    var num_stopped: Int64 = 0
    var num_starting: Int64 = 0
    var num_running: Int64 = 0
    var num_backoff: Int64 = 0
    var num_stopping: Int64 = 0
    var num_exited: Int64 = 0
    var num_fatal: Int64 = 0
    var num_unknown: Int64 = 0
    
    init(id: Int64?, sort_id: Int64?, ip: String, port: Int64, hostname: String, connection_scheme: String, num_cores: Int64,
        num_stopped: Int64, num_starting: Int64, num_running: Int64, num_backoff: Int64,
        num_stopping: Int64, num_exited: Int64, num_fatal: Int64, num_unknown: Int64) {
        self.id = id
        self.sort_id = sort_id
        self.ip = ip
        self.port = port
        self.connection_scheme = connection_scheme
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
        self.num_cores = Int64(try value.int("num_cores"))
        
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
                let table_exists_stmt = try db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name=?")
                if let row = table_exists_stmt.scalar(["server"]) {
                    print("Table '\(row)' exists.")
                } else {
                    // Table 'server' doesn't exist. So create it.
                    let stmt = try db.prepare("CREATE TABLE server (id INTEGER PRIMARY KEY AUTOINCREMENT, sort_id INTEGER, ip TEXT, port INTEGER, hostname TEXT, connection_scheme TEXT, num_cores INTEGER, num_stopped INTEGER, num_starting INTEGER, num_running INTEGER, num_backoff INTEGER, num_stopping INTEGER, num_exited INTEGER, num_fatal INTEGER, num_unknown INTEGER, created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UNIQUE(ip, port))")
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
    
    func processes() -> [Process] {
        return []
    }
    
    var description: String {
        get {
            return "<Server: id: \(self.id!), sort_id: \(self.sort_id!), ip: \(self.ip!), port: \(self.port!), connection_scheme: \(self.connection_scheme!), hostname: \(self.hostname!), num_cores: \(self.num_cores!), num_stopped: \(self.num_stopped), num_starting: \(self.num_starting), num_running: \(self.num_running), num_backoff: \(self.num_backoff), num_stopping: \(self.num_stopping), num_exited: \(self.num_exited), num_fatal: \(self.num_fatal), num_unknown: \(self.num_unknown)>"
        }
    }
}