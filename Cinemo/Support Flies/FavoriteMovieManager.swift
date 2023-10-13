//
//  FavoriteMovieManager.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
class FavoriteMovieManager {
    static let shared = FavoriteMovieManager()

    private init() {}
    private let favoritesKey = "favoritesMovieKey"


    var favorites: [Int] {
        get {
            return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: favoritesKey)
        }
    }
}
extension FavoriteMovieManager: Logic {
    // Add movie ID to favorites
    func addFavorite(movieID: Int) {
        var currentFavorites = favorites
        if !currentFavorites.contains(movieID) {
            currentFavorites.append(movieID)
            favorites = currentFavorites
        }
    }

    // Remove movie ID from favorites
    func removeFavorite(movieID: Int) {
        var currentFavorites = favorites
        if let index = currentFavorites.firstIndex(of: movieID) {
            currentFavorites.remove(at: index)
            favorites = currentFavorites
        }
    }

    // Check if a movie ID is a favorite
    func isFavorite(movieID: Int) -> Bool {
        return favorites.contains(movieID)
    }

    func getAllFavorites() -> [Int] {
        return favorites
    }
}
