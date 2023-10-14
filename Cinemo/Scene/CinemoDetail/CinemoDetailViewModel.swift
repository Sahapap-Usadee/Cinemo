//
//  CinemoDetailViewModel.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
import Combine
class CinemoDetailViewModel {
    // Outputs for the View
    @Published private(set) var dataModel: CinemoDetailModel
    @Published private(set) var isFavorite: Bool
    var cancellables = Set<AnyCancellable>()
    private let favoriteManager: FavoriteManaging

    init(data: CinemoDetailModel, favoriteManager: FavoriteManaging = FavoriteMovieManager.shared) {
        self.dataModel = data
        self.isFavorite = favoriteManager.isFavorite(movieID: data.id)
        self.favoriteManager = favoriteManager
    }
}

extension CinemoDetailViewModel: Logic {
    func toggleFavorite() {
        if isFavorite {
            favoriteManager.removeFavorite(movieID: dataModel.id)
            isFavorite = false
        } else {
            favoriteManager.addFavorite(movieID: dataModel.id)
            isFavorite = true
        }
    }
}
