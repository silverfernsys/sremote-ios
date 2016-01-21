//
//  LightTheme.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 1/20/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

class LightTheme: Theme {
    func styleNavigationController(navController: UINavigationController) -> Void {
        navController.navigationBar.barStyle = UIBarStyle.Default
        let navigationBarAppearance: UINavigationBar = UINavigationBar.appearance()
        navigationBarAppearance.barStyle = UIBarStyle.Default
    }
    
    func styleTableViewController(tableViewController: UITableViewController) -> Void {
        let tableViewCellAppearance: UITableViewCell = UITableViewCell.appearance()
        tableViewCellAppearance.backgroundColor = UIColor.whiteColor()
        
        let headerFooterViewAppearance:UITableViewHeaderFooterView = UITableViewHeaderFooterView.appearance()
        headerFooterViewAppearance.tintColor = UIColor.whiteColor()
        
        let tableViewAppearance: UITableView = UITableView.appearance()
        tableViewAppearance.backgroundColor = UIColor.whiteColor()
        
        let labelAppearance: UILabel = UILabel.appearance()
        labelAppearance.textColor = UIColor.blackColor()
        
        let badgeLabelAppearance: BadgeLabel = BadgeLabel.appearance()
        badgeLabelAppearance.textColor = UIColor.whiteColor()
        
        for cell in tableViewController.tableView.visibleCells {
            (cell as! ThemeableCell).theme()
        }
        
        tableViewController.tableView.backgroundColor = UIColor.whiteColor()
    }
    
    func cellSelectedBackgroundView() -> UIView? {
        return nil
    }
    
    func cellBackgroundColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    func cellPrimaryTextColor() -> UIColor {
        return UIColor.blackColor()
    }
    func cellSecondaryTextColor() -> UIColor {
        return UIColor.whiteColor()
    }
}