//
//  UIView+Extension.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit
enum CornerRadiusType {
    case roundDefault
    case roundHalf
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
    }


    func setCornerRadius(type: CornerRadiusType) {
        switch type {
        case .roundDefault:
            layer.cornerRadius = 8
        case .roundHalf:
            layer.cornerRadius = frame.height / 2
        case .none: break
        }
    }
}
