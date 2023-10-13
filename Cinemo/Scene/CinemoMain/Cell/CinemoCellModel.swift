//
//  CinemoCellModel.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
struct CinemoCellModel: Codable, Hashable {
    init(title: String, date: String, genre: String, posterURL: String) {
        self.title = title
        self.date = date
        self.genre = genre
        self.posterURL = posterURL
    }
    init() {
        self.title = ""
        self.date = ""
        self.genre = ""
        self.posterURL = ""
    }

    // MARK: Internal

    var title: String
    var date: String
    var genre: String
    var posterURL: String
}
