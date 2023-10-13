//
//  Label+Extension.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit
extension UILabel {
    func setThemeLabel(text: String = "", font: UIFont, textColor: UIColor? = nil, textFit: Bool = true) {
        let theme = ThemeManager.shared.currentTheme
        self.textColor = textColor ?? theme.colors.title
        self.text = text
        self.font = font
        if textFit {
            fitText()
        }
    }

    func fitText() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
    }
}
