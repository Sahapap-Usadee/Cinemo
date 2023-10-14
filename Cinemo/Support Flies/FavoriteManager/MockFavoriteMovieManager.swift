//
//  MockFavoriteMovieManager.swift
//  CinemoTests
//
//  Created by sahapap usadee on 14/10/2566 BE.
//

import Foundation
class MockFavoriteMovieManager: FavoriteManaging {
    var mockFavorites: [Int]

    init(favorites: [Int]) {
        self.mockFavorites = favorites
    }

    func addFavorite(movieID: Int) {
        mockFavorites.append(movieID)
    }

    func removeFavorite(movieID: Int) {
        mockFavorites.removeAll { $0 == movieID }
    }

    func isFavorite(movieID: Int) -> Bool {
        return mockFavorites.contains(movieID)
    }

    func getAllFavorites() -> [Int] {
        return mockFavorites
    }
}
