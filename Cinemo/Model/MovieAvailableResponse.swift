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
    let id: Int
    let movieCode: [String]?
    let titleEn, titleTh: String
    let rating: String
    let ratingID, duration: Int
    let releaseDate, sneakDate, synopsisTh, synopsisEn: String
    let director, actor, genre, posterOri: String
    let posterURL: String
    let trailer: String
    let trIos: String?
    let trHD, trSD: String?
    let trMp4: String
    let priority, nowShowing, advanceTicket: String?
    let dateUpdate: String
    let showBuyticket: String?
    let trailerCMSID: String
    let trailerIvxKey: String?

    enum CodingKeys: String, CodingKey {
        case id, movieCode
        case titleEn = "title_en"
        case titleTh = "title_th"
        case rating
        case ratingID = "rating_id"
        case duration
        case releaseDate = "release_date"
        case sneakDate = "sneak_date"
        case synopsisTh = "synopsis_th"
        case synopsisEn = "synopsis_en"
        case director, actor, genre
        case posterOri = "poster_ori"
        case posterURL = "poster_url"
        case trailer
        case trIos = "tr_ios"
        case trHD = "tr_hd"
        case trSD = "tr_sd"
        case trMp4 = "tr_mp4"
        case priority
        case nowShowing = "now_showing"
        case advanceTicket = "advance_ticket"
        case dateUpdate = "date_update"
        case showBuyticket = "show_buyticket"
        case trailerCMSID = "trailer_cms_id"
        case trailerIvxKey = "trailer_ivx_key"
    }
}
