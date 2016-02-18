//
//  UIColor+Colors.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/29/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

extension UIColor {
    public class func extraDarkGrey() -> UIColor {
        return UIColor(red: 34 / 256, green: 34 / 256, blue: 34 / 256, alpha: 1)
    }
    
    public class func extraDarkGreyLight() -> UIColor {
        return UIColor(red: 64 / 256, green: 64 / 256, blue: 64 / 256, alpha: 1)
    }
    
    public class func midBlue() -> UIColor {
        return UIColor(red: 0, green: 127 / 256, blue: 255 / 256, alpha: 0.5)
    }
    
    public class func midRed() -> UIColor {
        return UIColor(red: 204.0, green: 0.0, blue: 0.0, alpha: 0.5)
    }
}
