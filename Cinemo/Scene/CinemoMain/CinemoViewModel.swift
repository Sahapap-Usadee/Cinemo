//
//  CinemoMainViewModel.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Combine
import Localize_Swift

class CinemoViewModel {
    enum CinemoViewType {
        case movieList
        case favorites
    }
    // Outputs for the View
    @Published private(set) var dataModel: MovieAvailableResponse?
    @Published private(set) var error: Error?
    var cancellables = Set<AnyCancellable>()
    enum Section {
        case movieList
        case none
    }
    let sectionList: [Section]
    let viewType: CinemoViewType
    init(type: CinemoViewType = .movieList) {
        sectionList = [.movieList]
        self.viewType = type
    }
}

extension CinemoViewModel: Service {
    func fetchData() {
        CinemoClient.requestMovieAvailable { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataModel = data
            case .failure(let apiError):
                self?.error = apiError
            }
        }
    }
}

extension CinemoViewModel: Logic {
    func getMovielist() -> [MovieAvailable] {
        switch viewType {
        case .movieList:
            return dataModel?.movies ?? []
        case .favorites:
            let favoriteIDs = FavoriteMovieManager.shared.getAllFavorites()
            return dataModel?.movies.filter { favoriteIDs.contains($0.id) } ?? []
        }
    }

    func getMovieDetail(row: Int) -> CinemoDetailModel {
        let data = getMovielist()[row]
        var model: CinemoDetailModel =  .init()
        switch Constants.Language.Key(rawValue: Localize.currentLanguage()) {
        case .thai:
            model = CinemoDetailModel(id: data.id, title: data.titleTh, synopsis: data.synopsisTh, genre: data.genre, posterURL: data.posterURL)
        default:
            model = CinemoDetailModel(id: data.id, title: data.titleEn, synopsis: data.synopsisEn, genre: data.genre, posterURL: data.posterURL)
        }
        return model
    }

    func getModelMovie(row: Int) -> CinemoCellModel {
        let data = getMovielist()[row]
        var model: CinemoCellModel =  .init()
        switch Constants.Language.Key(rawValue: Localize.currentLanguage()) {
        case .thai:
            model = CinemoCellModel(title: data.titleTh, date: data.releaseDate, genre: data.genre, posterURL: data.posterURL)
        default:
            model = CinemoCellModel(title: data.titleEn, date: data.releaseDate, genre: data.genre, posterURL: data.posterURL)
        }
        return model
    }
}

extension CinemoViewModel {
    func numberOfSection() -> Int {
        sectionList.count
    }

    func sectionType(section: Int) -> Section {
        return sectionList.indices.contains(section) ? sectionList[section] : .none
    }

    func numberOfRowsInSection(in section: Int) -> Int {
        switch sectionList[section] {
        case .movieList: return self.getMovielist().count
        case .none: return 0
        }
    }
}
