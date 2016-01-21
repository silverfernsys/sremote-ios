//
//  ServerCell.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/20/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

class ServerCell: UITableViewCell, ThemeableCell {

    @IBOutlet weak var serverPortLabel: UILabel!
    @IBOutlet weak var serverAddressLabel: UILabel!
    
    @IBOutlet weak var stoppedCountLabel: BadgeLabel!
    @IBOutlet weak var stoppingCountLabel: BadgeLabel!
    @IBOutlet weak var runningCountLabel: BadgeLabel!
    @IBOutlet weak var startingCountLabel: BadgeLabel!
    @IBOutlet weak var restartingCountLabel: BadgeLabel!
    
    @IBOutlet weak var stoppedLabel: BadgeLabel!
    @IBOutlet weak var stoppingLabel: BadgeLabel!
    @IBOutlet weak var runningLabel: BadgeLabel!
    @IBOutlet weak var startingLabel: BadgeLabel!
    @IBOutlet weak var restartingLabel: BadgeLabel!
    
    @IBOutlet weak var stoppedView: UIView!
    @IBOutlet weak var stoppingView: UIView!
    @IBOutlet weak var runningView: UIView!
    @IBOutlet weak var startingView: UIView!
    @IBOutlet weak var restartingView: UIView!
    
    var server: ServerData! {
        didSet {
            serverAddressLabel.text = server.ip
            serverPortLabel.text = server.port
            
            stoppedCountLabel.text = String(server.stats!["stopped"] as Int!)
            stoppingCountLabel.text = String(server.stats!["stopping"] as Int!)
            runningCountLabel.text = String(server.stats!["running"] as Int!)
            startingCountLabel.text = String(server.stats!["starting"] as Int!)
            restartingCountLabel.text = String(server.stats!["restarting"] as Int!)
            
            layoutCountView(stoppedView, title: stoppedLabel, count: stoppedCountLabel, color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.5), padding: 5)
            layoutCountView(stoppingView, title: stoppingLabel, count: stoppingCountLabel, color:  UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.5), padding: 5)
            layoutCountView(runningView, title: runningLabel, count: runningCountLabel, color: UIColor(red: 0, green: 1, blue: 0, alpha: 0.5), padding: 5)
            layoutCountView(startingView, title: startingLabel, count: startingCountLabel, color: UIColor(red: 0, green: 0, blue: 1, alpha: 0.5), padding: 5)
            layoutCountView(restartingView, title: restartingLabel, count: restartingCountLabel, color: UIColor(red: 0, green: 1, blue: 1, alpha: 0.5), padding: 5)
            positionCountViews([runningView, startingView, restartingView, stoppingView, stoppedView])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCountView(stoppedView, title: stoppedLabel, count: stoppedCountLabel, color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.5), padding: 5)
        createCountView(stoppingView, title: stoppingLabel, count: stoppingCountLabel, color:  UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.5), padding: 5)
        createCountView(runningView, title: runningLabel, count: runningCountLabel, color: UIColor(red: 0, green: 1, blue: 0, alpha: 0.5), padding: 5)
        createCountView(startingView, title: startingLabel, count: startingCountLabel, color: UIColor.midBlue(), padding: 5)
        createCountView(restartingView, title: restartingLabel, count: restartingCountLabel, color: UIColor(red: 0, green: 1, blue: 1, alpha: 0.5), padding: 5)
        positionCountViews([runningView, startingView, restartingView, stoppingView, stoppedView])
    }
    
    func theme() {
        let theme: Theme = ThemeFactory.sharedInstance().theme
        self.selectedBackgroundView = theme.cellSelectedBackgroundView()
        self.backgroundColor = theme.cellBackgroundColor()
        
        serverAddressLabel.textColor = theme.cellPrimaryTextColor()
        serverPortLabel.textColor = theme.cellPrimaryTextColor()
        
        stoppedCountLabel.textColor = theme.cellSecondaryTextColor()
        stoppingCountLabel.textColor = theme.cellSecondaryTextColor()
        runningCountLabel.textColor = theme.cellSecondaryTextColor()
        startingCountLabel.textColor = theme.cellSecondaryTextColor()
        restartingCountLabel.textColor = theme.cellSecondaryTextColor()
        
        stoppedLabel.textColor = theme.cellSecondaryTextColor()
        stoppingLabel.textColor = theme.cellSecondaryTextColor()
        runningLabel.textColor = theme.cellSecondaryTextColor()
        startingLabel.textColor = theme.cellSecondaryTextColor()
        restartingLabel.textColor = theme.cellSecondaryTextColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func drawRoundedRect(size: CGSize, color: UIColor) -> UIImage {
        let path: UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), byRoundingCorners: [.AllCorners], cornerRadii: CGSize(width: 6.0, height: 6.0))
        
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
    
    func positionCountViews(views: [UIView]) {
        var countViewsWidth: CGFloat = 0.0
        for view in views {
            countViewsWidth += view.frame.width
        }
        let leftPadding: CGFloat = 15.0
        let rightPadding: CGFloat = 20.0
        
        let spacing: CGFloat = (self.frame.width - countViewsWidth - leftPadding - rightPadding) / (CGFloat(views.count) + 1)
        
        for i in 0..<views.count {
            if (i == 0) {
                let v: UIView = views[i]
                v.frame.origin.x = leftPadding
            } else {
                let prev: UIView = views[i - 1]
                let curr: UIView = views[i]
                curr.frame.origin.x = prev.frame.origin.x + prev.frame.size.width + spacing
            }
        }
    }
    
    func createCountView(view: UIView, title: UILabel, count: UILabel, color: UIColor, padding: CGFloat) {
        title.sizeToFit()
        count.sizeToFit()
        
        let width: CGFloat = ceil(max(title.intrinsicContentSize().width, count.intrinsicContentSize().width) + padding * 2)
        view.frame.size.width = width
        title.frame.origin = CGPoint(x: padding, y: padding)
        count.frame.origin = CGPoint(x: padding, y: padding)
        count.center = CGPoint(x: floor(width / 2), y: floor(view.frame.size.height / 2) + 6)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(imageView)
        imageView.image = drawRoundedRect(view.frame.size, color: color)
        view.sendSubviewToBack(imageView)
    }
    
    func layoutCountView(view: UIView, title: UILabel, count: UILabel, color: UIColor, padding: CGFloat) {
        title.sizeToFit()
        count.sizeToFit()
        
        let width: CGFloat = ceil(max(title.intrinsicContentSize().width, count.intrinsicContentSize().width) + padding * 2)
        view.frame.size.width = width
        title.frame.origin = CGPoint(x: padding, y: padding)
        count.frame.origin = CGPoint(x: padding, y: padding)
        count.center = CGPoint(x: floor(width / 2), y: floor(view.frame.size.height / 2) + 6)
    }
}
