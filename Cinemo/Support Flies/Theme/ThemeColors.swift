//
//  ThemeColors.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

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

    var headerTitle: UIColor {
        switch theme {
        case .defaultTheme: return UIColor(hex: "#5E5E5E")
        default: return UIColor(hex: "#5E5E5E")
        }
    }

    var subTitle: UIColor {
        switch theme {
        case .defaultTheme: return UIColor(hex: "#9F9FA7")
        default: return UIColor(hex: "#9F9FA7")
        }
    }

    var favorite: UIColor {
        switch theme {
        case .defaultTheme: return UIColor(hex: "#F21F81")
        default: return UIColor(hex: "#F21F81")
        }
    }
}
