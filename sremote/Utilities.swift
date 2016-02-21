//
//  Utilities.swift
//  sremote
//
//  Created by Marc Wilson on 2/18/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit
import Freddy

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

func isLandscape() -> Bool {
    switch UIDevice.currentDevice().orientation {
    case UIDeviceOrientation.Unknown:
        return false
    case UIDeviceOrientation.Portrait:
        return false
    case UIDeviceOrientation.PortraitUpsideDown:
        return false
    case UIDeviceOrientation.LandscapeLeft:
        return true
    case UIDeviceOrientation.LandscapeRight:
        return true
    default:
        return false
    }
}

func dataWithContentsOfFile(name: String, type: String) -> NSData? {
    guard let path = NSBundle.mainBundle().pathForResource(name, ofType: type) else {
        return nil
    }
    return NSData(contentsOfFile: path)
}

func pointArray(name: String) -> [CGPoint] {
    let data = dataWithContentsOfFile(name, type: "json")
    do {
        let json = try JSON(data: data!)
        let points = try json.array().map(CGPoint.init)
        return points
    } catch {
        return [CGPoint]()
    }
}
