//
//  Extensions.swift
//  GaioApp
//
//  Created by Giulia Duncan on 21/11/18.
//  Copyright © 2018 Gaio. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func topMostViewController() -> UIViewController {
        //print(type(of:self.presentedViewController))
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}
