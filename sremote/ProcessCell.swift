//
//  ProcessCell.swift
//  sremote
//
//  Created by Marc Wilson on 2/16/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

class ProcessCell: UITableViewCell, Themeable {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: BadgeLabel!
    @IBOutlet weak var uptimeLabel: UILabel!
    weak var cpuGraph: ThumbnailGraph!
    weak var memGraph: ThumbnailGraph!
    
    var process: Process! {
        didSet {
            let padding:CGFloat = 2.0
            var color = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            
            switch Int(process.state) {
            case Constants.ProcessStates.BACKOFF:
                color = Constants.ProcessStateColors.BACKOFF
                statusLabel.text = "BACKOFF"
                break
            case Constants.ProcessStates.EXITED:
                color = Constants.ProcessStateColors.EXITED
                statusLabel.text = "EXITED"
                break
            case Constants.ProcessStates.FATAL:
                color = Constants.ProcessStateColors.FATAL
                statusLabel.text = "FATAL"
                break
            case Constants.ProcessStates.RUNNING:
                color = Constants.ProcessStateColors.RUNNING
                statusLabel.text = "RUNNING"
                break
            case Constants.ProcessStates.STARTING:
                color = Constants.ProcessStateColors.STARTING
                statusLabel.text = "STARTING"
                break
            case Constants.ProcessStates.STOPPED:
                color = Constants.ProcessStateColors.STOPPED
                statusLabel.text = "STOPPED"
                break
            case Constants.ProcessStates.STOPPING:
                color = Constants.ProcessStateColors.STOPPING
                statusLabel.text = "STOPPING"
                break
            case Constants.ProcessStates.UNKNOWN:
                color = Constants.ProcessStateColors.UNKNOWN
                statusLabel.text = "UNKNOWN"
                break
            default:
                break
            }
            
            statusLabel.font = UIFont(name: "BankGothicBold", size: 20.0)
            statusLabel.backgroundColor = UIColor.clearColor()
            nameLabel.text = process.name
            uptimeLabel.font = UIFont(name: "BankGothicBold", size: 10.0)
            
            if let uptime = process.start {
                uptimeLabel.text = timestampFormat(uptime)
            } else {
                uptimeLabel.text = ""
            }
            
            layoutStatusView(statusView, title: statusLabel, subtitle: uptimeLabel, color: color, padding: padding)
            positionViews(self.frame.size)
        }
    }
    
    var _stateBackgroundWidth: CGFloat?
    let padding: CGFloat = 2.0
    
    var stateBackgroundWidth: CGFloat {
        get {
            if let s = _stateBackgroundWidth {
                return s
            } else {
                let l = UILabel()
                l.font = UIFont(name: "BankGothicBold", size: 20.0)
                let stateNames = [
                    "BACKOFF", "EXITED", "FATAL", "RUNNING", "STARTING", "STOPPED", "STOPPING", "UNKNOWN"
                ]
                var maxWidth: CGFloat = 0.0
                for stateName in stateNames {
                    l.text = stateName
                    l.sizeToFit()
                    maxWidth = max(l.frame.width + 2.0 * padding, maxWidth)
                }
                _stateBackgroundWidth = ceil(maxWidth)
                return _stateBackgroundWidth!
            }
        }
    }
    
    func timestampFormat(timestamp: Double) -> String {
        let ms: Int64 = Int64(timestamp * 1000.0) % 1000
        let s: Int64 = Int64(timestamp) % 60
        let m: Int64 = Int64(timestamp) / 60 % 60
        let h: Int64 = Int64(timestamp) / (60 * 60) % 60
        let d: Int64 = Int64(timestamp) / (60 * 60 * 24)
        
        let msStr = paddedNumber(ms, digits: 3)
        let sStr = paddedNumber(s, digits: 2)
        let mStr = paddedNumber(m, digits: 2)
        let hStr = paddedNumber(h, digits: 2)
        
        // No need for padding on days, so we'll just convert once if
        // need be.
        
        if d > 0 {
            return "\(d):\(hStr):\(mStr):\(sStr):\(msStr)"
        } else if h > 0 {
            return "\(hStr):\(mStr):\(sStr):\(msStr)"
        } else if m > 0 {
            return "\(mStr):\(sStr):\(msStr)"
        } else if s > 0 {
            return "\(sStr):\(msStr)"
        } else if ms > 0 {
            return "0.\(msStr)"
        } else {
            return "--:--:--"
        }
    }
    
    func paddedNumber(num: Int64, digits: Int) -> String {
        // Easy hack to find out how much padding to provide:
        // First convert 'num' to string and then look at the
        // the string's length.
        let numStr = "\(num)"
        let paddingCount = digits - numStr.characters.count
        if paddingCount > 0 {
            let padding = String(count: paddingCount, repeatedValue: ("0" as Character))
            return "\(padding)\(numStr)"
        } else {
            return numStr
        }
    }
    
    func layoutStatusView(view: UIView, title: UILabel, subtitle: UILabel, color: UIColor, padding: CGFloat) {
        title.sizeToFit()
        subtitle.sizeToFit()
        
        var size: CGSize
        if let text = subtitle.text {
            if text.characters.count > 0 {
                size = CGSize(width: self.stateBackgroundWidth, height: ceil(title.intrinsicContentSize().height + subtitle.intrinsicContentSize().height + padding * 2))
            } else {
                size = CGSize(width: self.stateBackgroundWidth, height: ceil(title.intrinsicContentSize().height + padding * 2))
            }
        } else {
            size = CGSize(width: self.stateBackgroundWidth, height: ceil(title.intrinsicContentSize().height + padding * 2))
        }
        
        view.frame.size = size
        title.frame.origin = CGPoint(x: (self.stateBackgroundWidth - title.intrinsicContentSize().width) / 2.0, y: padding)
        subtitle.frame.origin = CGPoint(x: (self.stateBackgroundWidth - subtitle.intrinsicContentSize().width) / 2.0, y: size.height - (subtitle.frame.size.height + padding))
        
        for subview in view.subviews {
            if let roundedRect = subview as? UIImageView {
                roundedRect.removeFromSuperview()
            }
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(imageView)
        imageView.image = drawRoundedRect(view.frame.size, color: color)
        view.sendSubviewToBack(imageView)
        view.backgroundColor = UIColor.clearColor()
        view.addSubview(title)
        view.addSubview(subtitle)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.autoresizesSubviews = false
        self.layoutMargins.left = 0
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.2
        
        let padding:CGFloat = 2.0
        
        let cpu = ThumbnailGraph(frame: CGRect(x: 0, y: 44, width: self.frame.width / 2, height: 44), color: UIColor.midBlue())
        let mem = ThumbnailGraph(frame: CGRect(x: self.frame.width / 2 + 1, y: 44, width: self.frame.width / 2, height: 44), color: UIColor.midRed())
        
        var cpuPoints = [CGPoint]()
        for i in 0..<200 {
            cpuPoints.append(CGPoint(x: Double(i), y: 21.0 * sin(Double(i) * M_PI * 2.0 / 100.0) + 22.0))
        }
        
        var memPoints = [CGPoint]()
        for i in 0..<200 {
            memPoints.append(CGPoint(x: Double(i), y: 21.0 * cos(Double(i) * M_PI * 2.0 / 100.0) + 22.0))
        }
        
        cpu.points = cpuPoints
        mem.points = memPoints
        
        self.addSubview(cpu)
        self.addSubview(mem)
        
        cpuGraph = cpu
        memGraph = mem
        layoutStatusView(statusView, title: self.statusLabel, subtitle: self.uptimeLabel, color: UIColor.redColor(), padding: padding)
        positionViews(self.frame.size)
    }
    
    func positionViews(size: CGSize) {
        statusView.frame.origin = CGPoint(x: size.width - statusView.frame.size.width - 6.0, y: (44.0 - statusView.frame.size.height) / 2.0)
        nameLabel.frame.size = CGSize(width:statusView.frame.origin.x - nameLabel.frame.origin.x - 6, height: nameLabel.frame.size.height)
    }
    
    func theme() {
        let theme: Theme = ThemeFactory.sharedInstance().theme
        self.selectedBackgroundView = theme.cellSelectedBackgroundView()
        self.backgroundColor = theme.cellBackgroundColor()
        
        nameLabel.textColor = theme.cellPrimaryTextColor()
        uptimeLabel.textColor = theme.cellSecondaryTextColor()
        statusLabel.textColor = theme.cellSecondaryTextColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
