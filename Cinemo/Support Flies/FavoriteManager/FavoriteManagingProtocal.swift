//
//  FavoriteManagingProtocal.swift
//  Cinemo
//
//  Created by sahapap usadee on 14/10/2566 BE.
//

import Foundation

protocol FavoriteManaging {
    func addFavorite(movieID: Int)
    func removeFavorite(movieID: Int)
    func isFavorite(movieID: Int) -> Bool
    func getAllFavorites() -> [Int]
}
