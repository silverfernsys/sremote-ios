//
//  CGPoint+JSONDecodable.swift
//  sremote
//
//  Created by Marc Wilson on 2/20/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import Freddy

extension CGPoint: JSONDecodable {
    public init(json: JSON) throws {
        if let x = try json.array().first?.double() {
            self.x = CGFloat(x)
        } else {
            self.x = 0.0
        }
        if let y = try json.array().last?.double() {
            self.y = CGFloat(y)
        } else {
            self.y = 0.0
        }
    }
}