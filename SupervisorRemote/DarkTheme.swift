//
//  DarkTheme.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 1/20/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

class DarkTheme: Theme {
    func styleNavigationController(navController: UINavigationController) -> Void {
        navController.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        let navigationBarAppearance: UINavigationBar = UINavigationBar.appearance()
        navigationBarAppearance.barStyle = UIBarStyle.BlackTranslucent
    }
    
    func styleTableViewController(tableViewController: UITableViewController) -> Void {
        let tableViewCellAppearance: UITableViewCell = UITableViewCell.appearance()
        tableViewCellAppearance.backgroundColor = UIColor.extraDarkGrey()
        
        let headerFooterViewAppearance:UITableViewHeaderFooterView = UITableViewHeaderFooterView.appearance()
        headerFooterViewAppearance.tintColor = UIColor.extraDarkGrey()
        
        let tableViewAppearance: UITableView = UITableView.appearance()
        tableViewAppearance.backgroundColor = UIColor.extraDarkGrey()
        
        let labelAppearance: UILabel = UILabel.appearance()
        labelAppearance.textColor = UIColor.whiteColor()
        
        let badgeLabelAppearance: BadgeLabel = BadgeLabel.appearance()
        badgeLabelAppearance.textColor = UIColor.blackColor()
        
        for cell in tableViewController.tableView.visibleCells {
            (cell as! ThemeableCell).theme()
        }
        
        tableViewController.tableView.backgroundColor = UIColor.extraDarkGrey()
    }
    
    func cellSelectedBackgroundView() -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.extraDarkGreyLight()
        return view
    }
    
    func cellBackgroundColor() -> UIColor {
        return UIColor.extraDarkGrey()
    }
    
    func cellPrimaryTextColor() -> UIColor {
        return UIColor.whiteColor()
    }
    func cellSecondaryTextColor() -> UIColor {
        return UIColor.blackColor()
    }
}