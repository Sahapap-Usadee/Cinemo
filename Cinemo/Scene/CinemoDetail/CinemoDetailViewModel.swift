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
    private let favoriteManager = FavoriteMovieManager.shared

    init(data: CinemoDetailModel) {
        self.dataModel = data
        self.isFavorite = favoriteManager.isFavorite(movieID: data.id)
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
