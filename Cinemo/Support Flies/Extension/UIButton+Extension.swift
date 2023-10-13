//
//  UIButton+Extension.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

extension UIButton {
    func setAddFavoriteButton() {
        let theme = ThemeManager.shared.currentTheme
        setThemeButton(
            text: "Add to Favorite".localized(),
            font: theme.fonts.button,
            textColor: theme.colors.titleOnTint,
            backgroundColor: theme.colors.favorite,
            borderWidth: 0.0,
            borderColor: .clear,
            roundType: .roundHalf
        )
    }

    func setRemoveFavoriteButton() {
        let theme = ThemeManager.shared.currentTheme
        setThemeButton(
            text: "Remove Favorite".localized(),
            font: theme.fonts.button,
            textColor: theme.colors.titleOnTint,
            backgroundColor: theme.colors.favorite,
            borderWidth: 0.0,
            borderColor: .clear,
            roundType: .roundHalf
        )
    }
}

extension UIButton {
    private func setThemeButton(
        text: String? = nil,
        font: UIFont? = nil,
        textColor: UIColor? = nil,
        backgroundColor: UIColor? = nil,
        borderWidth: CGFloat = 0.0,
        borderColor: UIColor? = nil,
        roundType: CornerRadiusType = .roundDefault
    ) {
        isHaptic = true
        hapticType = .impact(.medium)
        let theme = ThemeManager.shared.currentTheme
        let font = font ?? theme.fonts.button
        let textColor = textColor ?? theme.colors.titleOnTint
        let backgroundColor = backgroundColor ?? theme.colors.main

        if let text = text {
            setTitle(text, for: .normal)
        }
        titleLabel?.font = font

        setTitleColor(
            textColor,
            for: .normal
        )


        self.backgroundColor = backgroundColor

        if let borderColor = borderColor {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }

        setCornerRadius(type: roundType)
    }

    func setInternalImage(asset: Assets, alwaysOriginal: Bool = false, state: UIControl.State = .normal) {
        let image = alwaysOriginal ? asset.image.withRenderingMode(.alwaysOriginal) : asset.image
        setImage(image, for: state)
    }
}
