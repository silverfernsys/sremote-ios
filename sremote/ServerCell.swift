//
//  ServerCell.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/20/15.
//  Copyright © 2015 - 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

class DeleteButton: UIButton {
    static let kDeleteButtonWidth = 80.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
        self.setTitle("Delete", forState: UIControlState.Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func maskWithRect(frame: CGRect) {
        let mask : UIView = UIView(frame: frame)
        mask.backgroundColor = UIColor.whiteColor()
        self.maskView = mask
    }
}

class ServerCell: UITableViewCell, Themeable {

    @IBOutlet weak var serverPortLabel: UILabel!
    @IBOutlet weak var serverAddressLabel: UILabel!
    
    @IBOutlet weak var stoppedCountLabel: BadgeLabel!
    @IBOutlet weak var startingCountLabel: BadgeLabel!
    @IBOutlet weak var runningCountLabel: BadgeLabel!
    @IBOutlet weak var backoffCountLabel: BadgeLabel!
    @IBOutlet weak var stoppingCountLabel: BadgeLabel!
    @IBOutlet weak var exitedCountLabel: BadgeLabel!
    @IBOutlet weak var fatalCountLabel: BadgeLabel!
    @IBOutlet weak var unknownCountLabel: BadgeLabel!
    
    @IBOutlet weak var stoppedLabel: BadgeLabel!
    @IBOutlet weak var startingLabel: BadgeLabel!
    @IBOutlet weak var runningLabel: BadgeLabel!
    @IBOutlet weak var backoffLabel: BadgeLabel!
    @IBOutlet weak var stoppingLabel: BadgeLabel!
    @IBOutlet weak var exitedLabel: BadgeLabel!
    @IBOutlet weak var fatalLabel: BadgeLabel!
    @IBOutlet weak var unknownLabel: BadgeLabel!
    
    @IBOutlet weak var stoppedView: UIView!
    @IBOutlet weak var startingView: UIView!
    @IBOutlet weak var runningView: UIView!
    @IBOutlet weak var backoffView: UIView!
    @IBOutlet weak var stoppingView: UIView!
    @IBOutlet weak var exitedView: UIView!
    @IBOutlet weak var fatalView: UIView!
    @IBOutlet weak var unknownView: UIView!
    var container: UIView!
    
    var deleteButton: DeleteButton!
    
    var server: ServerData! {
        didSet {
            serverAddressLabel.text = server.ip
            serverPortLabel.text = server.port
            
            stoppedCountLabel.text = String(server.stats!["stopped"] as Int!)
            startingCountLabel.text = String(server.stats!["starting"] as Int!)
            runningCountLabel.text = String(server.stats!["running"] as Int!)
            backoffCountLabel.text = String(server.stats!["backoff"] as Int!)
            stoppingCountLabel.text = String(server.stats!["stopping"] as Int!)
            exitedCountLabel.text = String(server.stats!["exited"] as Int!)
            fatalCountLabel.text = String(server.stats!["fatal"] as Int!)
            unknownCountLabel.text = String(server.stats!["unknown"] as Int!)
            
            let padding:CGFloat = 2.0
            layoutCountView(stoppedView, title: stoppedLabel, count: stoppedCountLabel, color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.5), padding: padding)
            layoutCountView(startingView, title: startingLabel, count: startingCountLabel, color: UIColor(red: 0, green: 0, blue: 1, alpha: 0.5), padding: padding)
            layoutCountView(runningView, title: runningLabel, count: runningCountLabel, color: UIColor(red: 0, green: 1, blue: 0, alpha: 0.5), padding: padding)
            layoutCountView(backoffView, title: backoffLabel, count: backoffCountLabel, color: UIColor(red: 0, green: 1, blue: 1, alpha: 0.5), padding: padding)
            layoutCountView(stoppingView, title: stoppingLabel, count: stoppingCountLabel, color:  UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.5), padding: padding)
            layoutCountView(exitedView, title: exitedLabel, count: exitedCountLabel, color: UIColor(red: 1, green: 0, blue: 1, alpha: 0.5), padding: padding)
            
            // 153,50,204
            layoutCountView(fatalView, title: fatalLabel, count: fatalCountLabel, color: UIColor(red: (153.0 / 255.0), green: (50.0 / 255.0), blue: (204.0 / 255.0), alpha: 0.5), padding: padding)
            layoutCountView(unknownView, title: unknownLabel, count: unknownCountLabel, color:  UIColor(red: (190.0 / 255.0), green: (190.0 / 255.0), blue: (190.0 / 255.0), alpha: 0.5), padding: padding)
            
            positionCountViews([stoppedView, startingView, runningView, backoffView, stoppingView, exitedView, fatalView, unknownView])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.autoresizesSubviews = false
        self.layoutMargins.left = 0
        let padding:CGFloat = 2.0
        container = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        container.backgroundColor = UIColor.clearColor()
        container.addSubview(serverAddressLabel)
        container.addSubview(serverPortLabel)
        
        self.addSubview(container)
        createCountView(stoppedView, title: stoppedLabel, count: stoppedCountLabel, color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.5), padding: padding)
        createCountView(startingView, title: startingLabel, count: startingCountLabel, color: UIColor.midBlue(), padding: padding)
        createCountView(runningView, title: runningLabel, count: runningCountLabel, color: UIColor(red: 0, green: 1, blue: 0, alpha: 0.5), padding: padding)
        createCountView(backoffView, title: backoffLabel, count: backoffCountLabel, color: UIColor(red: 0, green: 1, blue: 1, alpha: 0.5), padding: padding)
        createCountView(stoppingView, title: stoppingLabel, count: stoppingCountLabel, color:  UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.5), padding: padding)
        createCountView(exitedView, title: exitedLabel, count: exitedCountLabel, color: UIColor(red: 1, green: 0, blue: 1, alpha: 0.5), padding: padding)
        createCountView(fatalView, title: fatalLabel, count: fatalCountLabel, color: UIColor(red: (153.0 / 255.0), green: (50.0 / 255.0), blue: (204.0 / 255.0), alpha: 0.5), padding: padding)
        createCountView(unknownView, title: unknownLabel, count: unknownCountLabel, color:  UIColor(red: (190.0 / 255.0), green: (190.0 / 255.0), blue: (190.0 / 255.0), alpha: 0.5), padding: padding)
        
        positionCountViews([stoppedView, startingView, runningView, backoffView, stoppingView, exitedView, fatalView, unknownView])
        
        let deleteBtn : DeleteButton = DeleteButton(frame: CGRect(x: 0, y: 0, width: 80, height: self.frame.height))
        self.addSubview(deleteBtn)
        deleteButton = deleteBtn
        deleteButton.addTarget(self, action: Selector("handleDelete:"), forControlEvents: UIControlEvents.TouchUpInside)
        deleteButton.maskWithRect(CGRect(x: 0, y: 0, width: 0, height: self.frame.height))
        deleteButton.enabled = false
    }
    
    func positionViews() {
        positionCountViews([stoppedView, startingView, runningView, backoffView, stoppingView, exitedView, fatalView, unknownView])
    }
    
    func theme() {
        let theme: Theme = ThemeFactory.sharedInstance().theme
        self.selectedBackgroundView = theme.cellSelectedBackgroundView()
        self.backgroundColor = theme.cellBackgroundColor()
        
        serverAddressLabel.textColor = theme.cellPrimaryTextColor()
        serverPortLabel.textColor = theme.cellPrimaryTextColor()
        
        stoppedCountLabel.textColor = theme.cellSecondaryTextColor()
        startingCountLabel.textColor = theme.cellSecondaryTextColor()
        runningCountLabel.textColor = theme.cellSecondaryTextColor()
        backoffCountLabel.textColor = theme.cellSecondaryTextColor()
        stoppingCountLabel.textColor = theme.cellSecondaryTextColor()
        exitedCountLabel.textColor = theme.cellSecondaryTextColor()
        fatalCountLabel.textColor = theme.cellSecondaryTextColor()
        unknownCountLabel.textColor = theme.cellSecondaryTextColor()
        
        stoppedLabel.textColor = theme.cellSecondaryTextColor()
        startingLabel.textColor = theme.cellSecondaryTextColor()
        runningLabel.textColor = theme.cellSecondaryTextColor()
        backoffLabel.textColor = theme.cellSecondaryTextColor()
        stoppingLabel.textColor = theme.cellSecondaryTextColor()
        exitedLabel.textColor = theme.cellSecondaryTextColor()
        fatalLabel.textColor = theme.cellSecondaryTextColor()
        unknownLabel.textColor = theme.cellSecondaryTextColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /*
    -(void)maskWithCircle:(UIImageView*)imgView{
    
    CAShapeLayer *aCircle=[CAShapeLayer layer];
    aCircle.path=[UIBezierPath bezierPathWithRoundedRect:imgView.bounds cornerRadius:imgView.frame.size.height/2].CGPath; // Considering the ImageView is square in Shape
    
    aCircle.fillColor=[UIColor blackColor].CGColor;
    imgView.layer.mask=aCircle;
    
    }
    */
    
    func showDelete() {
        UIView.animateWithDuration(0.15, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.deleteButton.maskView?.frame = CGRectMake(0, 0, (CGFloat)(DeleteButton.kDeleteButtonWidth), self.frame.height)
            self.container.frame = CGRect(x: 80, y: 0, width: self.container.frame.width, height: self.container.frame.height)
            self.setNeedsDisplay()
            }, completion: {
                finish in print("complete")
                self.deleteButton.enabled = true
        })
    }
    
    func hideDelete(animated: Bool) {
        if animated {
            UIView.animateWithDuration(0.15, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.deleteButton.enabled = false
                self.deleteButton.maskView?.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.height)
                self.container.frame = CGRect(x: 0, y: 0, width: self.container.frame.width, height: self.container.frame.height)
                }, completion: {
                    finish in print("complete")
            })
        } else {
            self.deleteButton.enabled = false
            self.deleteButton.maskView?.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.height)
            self.container.frame = CGRect(x: 0, y: 0, width: self.container.frame.width, height: self.container.frame.height)
        }
    }
    
    func handleDelete(sender: UIButton) {
        print("handleDelete")
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.ServerListViewController.DeleteServer, object: self)
    }
    
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
    
    func positionCountViews(views: [UIView]) {
        var countViewsWidth: CGFloat = 0.0
        for view in views {
            countViewsWidth += view.frame.width
        }
        
        let leftPadding: CGFloat = 5
        let rightPadding: CGFloat = 5
        
        let spacing: CGFloat = (self.frame.width - countViewsWidth - leftPadding - rightPadding) / (CGFloat(views.count - 1))
        
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
        title.font = UIFont.systemFontOfSize(10)
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
        
        container.addSubview(view)
    }
    
    func layoutCountView(view: UIView, title: UILabel, count: UILabel, color: UIColor, padding: CGFloat) {
        title.font = UIFont.systemFontOfSize(10)
        title.sizeToFit()
        count.sizeToFit()
        
        let width: CGFloat = ceil(max(title.intrinsicContentSize().width, count.intrinsicContentSize().width) + padding * 2)
        view.frame.size.width = width
        title.frame.origin = CGPoint(x: padding, y: padding)
        count.frame.origin = CGPoint(x: padding, y: padding)
        count.center = CGPoint(x: floor(width / 2), y: floor(view.frame.size.height / 2) + 6)
    }
}
