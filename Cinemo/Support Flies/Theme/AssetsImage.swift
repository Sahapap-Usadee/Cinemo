//
//  AssetsImage.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

// MARK: - Assets

enum Assets: String {
    case heartIcon

    // MARK: Internal

    var image: UIImage {
        return UIImage(named: rawValue)!
    }
}
