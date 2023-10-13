//
//  UIView+Extension.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit
enum CornerRadiusType {
    case roundDefault
    case none
}

extension UIView {
    func setThemeView(
        backgroundColor: UIColor = .clear,
        borderColor: UIColor? = nil,
        roundType: CornerRadiusType = .none
    ) {
        self.backgroundColor = backgroundColor
        if let borderColor = borderColor {
            layer.borderWidth = 1
            layer.borderColor = borderColor.cgColor
        }

        setCornerRadius(type: roundType)
        self.clipsToBounds = clipsToBounds
    }


    func setCornerRadius(type: CornerRadiusType) {
        switch type {
        case .roundDefault:
            layer.cornerRadius = 5
        case .none: break
        }
    }
}
