//
//  ThemeColors.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit
import Hue
struct ThemeColors {
    var theme: Theme

    var main: UIColor {
        switch theme {
        case .defaultTheme: return UIColor(hex: "#000000")
        default: return UIColor(hex: "#000000")
        }
    }

    var background: UIColor {
        switch theme {
        case .defaultTheme: return UIColor(hex: "#FFFFFF")
        default: return UIColor(hex: "#FFFFFF")
        }
    }

    var card: UIColor {
        switch theme {
        case .defaultTheme: return UIColor(hex: "#f8f8f8")
        default: return UIColor(hex: "#f8f8f8")
        }
    }


    var titleOnTint: UIColor {
        switch theme {
        case .defaultTheme: return UIColor(hex: "#FFFFFF")
        default: return UIColor(hex: "#FFFFFF")
        }
    }

    var title: UIColor {
        switch theme {
        case .defaultTheme: return UIColor(hex: "#000000")
        default: return UIColor(hex: "#000000")
        }
    }

    var subTitle: UIColor {
        switch theme {
        case .defaultTheme: return UIColor(hex: "#bdc3c7")
        default: return UIColor(hex: "#bdc3c7")
        }
    }
}
