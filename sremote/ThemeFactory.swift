//
//  Theme.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 1/20/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import UIKit

class ThemeFactory {
    static let _instance: ThemeFactory = ThemeFactory()
    var _theme: Theme
    
    init() {
        _theme = LightTheme()
    }
    
    init(preference: Int) {
        switch preference {
        case Constants.Theme.LIGHT:
            _theme = LightTheme()
        case Constants.Theme.DARK:
            _theme = DarkTheme()
        default:
            _theme = LightTheme()
        }
    }
    
    static func sharedInstance() -> ThemeFactory {
        return _instance
    }
    
    var theme: Theme {
        get {
            return _theme
        }
    }
    
    func themeWithPreference(preference: Int) -> Theme {
        switch preference {
        case Constants.Theme.LIGHT:
            return lightTheme()
        case Constants.Theme.DARK:
            return darkTheme()
        default:
            return lightTheme()
        }
    }
    
    func lightTheme() -> Theme {
        if !(_theme is LightTheme) {
                _theme = LightTheme()
        }
        return _theme
    }
    
    func darkTheme() -> Theme {
        if !(_theme is DarkTheme) {
            _theme = DarkTheme()
        }
        return _theme
    }
}
