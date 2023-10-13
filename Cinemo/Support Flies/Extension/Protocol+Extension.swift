//
//  Protocol+Extension.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

// MARK: - Service

protocol Service {}

// MARK: - Logic

protocol Logic {}

// MARK: - UserInterface

protocol UserInterface {}

// MARK: - Action

protocol Action {}


protocol Themes {
    func applyTheme()
}


// MARK: - AlertPresentation

protocol AlertPresentation {}

// MARK: - ViewControllerPresentation

protocol ViewControllerPresentation {}

enum TabbarMenu {
    case home
    case account
    case trade
    case research
    case more
}

protocol ViewInstantiation {
    static var identifier: String { get }
    static var nib: UINib { get }
}
