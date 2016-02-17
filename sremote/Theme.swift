//
//  ThemeProtocol.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 1/20/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

protocol Theme {
    func styleNavigationController(navController: UINavigationController) -> Void
    func styleTableViewController(tableViewController: UITableViewController) -> Void
    func styleViewController(viewController: UIViewController) -> Void
    func cellSelectedBackgroundView() -> UIView?
    func cellBackgroundColor() -> UIColor
    func cellPrimaryTextColor() -> UIColor
    func cellSecondaryTextColor() -> UIColor
}