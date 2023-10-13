//
//  CinemoDetailModel.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
struct CinemoDetailModel: Codable, Hashable {
    init(id: Int, title: String, synopsis: String, genre: String, posterURL: String) {
        self.id = id
        self.title = title
        self.synopsis = synopsis
        self.genre = genre
        self.posterURL = posterURL
    }

    init() {
        self.id = 0
        self.title = ""
        self.synopsis = ""
        self.genre = ""
        self.posterURL = ""
    }

    // MARK: Internal
    var id: Int
    var title: String
    var synopsis: String
    var genre: String
    var posterURL: String
}
