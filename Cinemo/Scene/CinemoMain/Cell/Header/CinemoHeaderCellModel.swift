//
//  CinemoHeaderCellModel.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
struct CinemoHeaderCellModel: Codable, Hashable {
    init(title: String) {
        self.title = title
    }
    init() {
        self.title = ""
    }

    // MARK: Internal

    var title: String
}
