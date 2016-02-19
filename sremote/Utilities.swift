//
//  Utilities.swift
//  sremote
//
//  Created by Marc Wilson on 2/18/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

func drawRoundedRect(size: CGSize, color: UIColor) -> UIImage {
    let path: UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), byRoundingCorners: [.AllCorners], cornerRadii: CGSize(width: 3.0, height: 3.0))
    
    UIGraphicsBeginImageContext(size)
    UIGraphicsGetCurrentContext()
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextBeginPath(context)
    CGContextAddPath(context, path.CGPath)
    CGContextFillPath(context)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}