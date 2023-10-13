//
//  MovieAvailableResponse.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation

// MARK: - MovieAvailableResponse
struct MovieAvailableResponse: Codable {
    let movies: [MovieAvailable]
}

// MARK: - Movie
struct MovieAvailable: Codable {
    let titleEn, titleTh: String
    let rating: String
    let releaseDate, sneakDate, synopsisTh, synopsisEn: String
    let director, actor, genre, posterOri: String
    let posterURL: String
    let dateUpdate: String


    enum CodingKeys: String, CodingKey {
        case titleEn = "title_en"
        case titleTh = "title_th"
        case rating
        case releaseDate = "release_date"
        case sneakDate = "sneak_date"
        case synopsisTh = "synopsis_th"
        case synopsisEn = "synopsis_en"
        case director, actor, genre
        case posterOri = "poster_ori"
        case posterURL = "poster_url"
        case dateUpdate = "date_update"
    }
    init() {
        self.titleEn = ""
        self.titleTh = ""
        self.rating = ""
        self.releaseDate = ""
        self.sneakDate = ""
        self.synopsisTh = ""
        self.synopsisEn = ""
        self.director = ""
        self.actor = ""
        self.genre = ""
        self.posterOri = ""
        self.posterURL = ""
        self.dateUpdate = ""
    }
}
