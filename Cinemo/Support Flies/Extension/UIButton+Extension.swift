//
//  UIButton+Extension.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit
extension UIButton {
    func setInternalImage(asset: Assets, alwaysOriginal: Bool = false, state: UIControl.State = .normal) {
        let image = alwaysOriginal ? asset.image.withRenderingMode(.alwaysOriginal) : asset.image
        setImage(image, for: state)
    }
}
