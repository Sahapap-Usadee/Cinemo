//
//  NavigationBarManager.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//


import UIKit

class NavigationBarManager {
    // MARK: Internal

    static func configure(title: String, rightNavBar: NavigationBarItemConfiguration = .none, on viewController: UIViewController) {
        if let navBar = viewController.navigationController?.navigationBar as? CinemoNavigatorBar {
            navBar.initView()
            navBar.setupRightNavigationBarItems(configuration: rightNavBar)
        }

        viewController.navigationController?.setTitle(title: title)
    }
}
