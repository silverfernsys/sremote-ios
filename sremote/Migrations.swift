//
//  Migration.swift
//  sremote
//
//  Created by Marc Wilson on 2/15/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import SQLite

class Migrations {
    enum Direction {
        case Up, Down
    }
    
    var db: Connection
    
    init(db: Connection) {
        self.db = db
    }
    
    func run(direction: Direction = Migrations.Direction.Up) {
        Server.migrate(self.db, direction: direction)
        Process.migrate(self.db, direction: direction)
    }
}
