//
//  UIImageView+Extension.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Kingfisher
import UIKit

extension UIImageView {
    //    func setImage(image: Assets, tintColor: UIColor? = nil, contentMode: ContentMode? = nil) {
    //        var image = image.image
    //        if let tintColor {
    //            image = image.withTintColor(tintColor)
    //        }
    //        if let contentMode {
    //            self.contentMode = contentMode
    //        }
    //        self.image = image
    //    }

    func setImageFromURL(url: String, resize: ContentMode = .scaleAspectFill) {
        contentMode = resize
        guard let url = URL(string: url) else { return }
        let theme = ThemeManager.shared.currentTheme
        KF.url(url)
            .placeholder(nil)
            .fade(duration: 0.0)
            .onSuccess { _ in
                self.backgroundColor = .clear
            }
            .onFailure { _ in
                self.backgroundColor = theme.colors.main
            }
            .set(to: self)
    }
}
