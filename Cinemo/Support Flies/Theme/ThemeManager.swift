//
//  ThemeManager.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation

// MARK: - Theme

enum Theme: Int {
    case defaultTheme
    case none

    var colors: ThemeColors {
        return ThemeColors(theme: self)
    }

    var fonts: ThemeFonts {
        return ThemeFonts(theme: self)
    }
}

// MARK: - ThemeManager

class ThemeManager {
    // MARK: Lifecycle

    private init() {
        if
            let storedTheme = UserDefaults.standard.value(forKey: selectedThemeKey) as? Int,
            let theme = Theme(rawValue: storedTheme)
        {
            currentTheme = theme
        } else {
            currentTheme = .defaultTheme
        }
    }

    // MARK: Internal

    // Singleton instance
    static let shared = ThemeManager()

    let selectedThemeKey = "SelectedTheme"

    var currentTheme: Theme {
        didSet {
            UserDefaults.standard.setValue(currentTheme.rawValue, forKey: selectedThemeKey)
        }
    }

    // Set theme
    func setTheme(_ theme: Theme) {
        currentTheme = theme
    }
}
