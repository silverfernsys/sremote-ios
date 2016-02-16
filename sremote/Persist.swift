//
//  Persist.swift
//  sremote
//
//  Created by Marc Wilson on 2/15/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import SQLite

protocol Persist {
    static func migrate(db:Connection, direction: Migrations.Direction)
    func save() -> Bool
    func delete() -> Bool
}