//
//  InputCell.swift
//  sremote
//
//  Created by Marc Wilson on 2/11/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

class InputCell: UITableViewCell, Themeable {
    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.autoresizesSubviews = false
        self.layoutMargins.left = 0
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawLine(CGPoint(x: 12, y: 59))
    }
    
    func drawLine(position:CGPoint) {
        let path = UIBezierPath()
        path.moveToPoint(position)
        path.addLineToPoint(CGPointMake(self.frame.width - position.x, position.y))
        path.lineWidth = 1
        let dashes: [CGFloat] = [path.lineWidth * 0, path.lineWidth * 2]
        path.setLineDash(dashes, count: dashes.count, phase: 0)
        path.lineCapStyle = CGLineCap.Round
        UIColor.lightGrayColor().setFill()
        UIColor.lightGrayColor().setStroke()
        path.stroke()
        path.fill()
    }
    
    func theme() {
        //
    }
}
