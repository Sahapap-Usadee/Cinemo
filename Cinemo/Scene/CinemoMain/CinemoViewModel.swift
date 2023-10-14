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
    @Published private(set) var dataModel: [MovieAvailable]?
    @Published private(set) var error: Error?
    private var favoriteMovieManager: FavoriteManaging
    private var currentSearchText: String?
    private var allMovies: [MovieAvailable]
    var cancellables = Set<AnyCancellable>()
    enum Section {
        case movieList
        case none
    }
    let sectionList: [Section]
    let viewType: CinemoViewType
    init(type: CinemoViewType = .movieList, favoriteMovieManager: FavoriteManaging = FavoriteMovieManager.shared) {
        sectionList = [.movieList]
        self.viewType = type
        self.allMovies = []
        self.favoriteMovieManager = favoriteMovieManager
    }

    init(type: CinemoViewType = .movieList, mockData: [MovieAvailable]? = nil, mockFavoriteMovie: FavoriteManaging = FavoriteMovieManager.shared) {
        self.viewType = type
        self.sectionList = [.movieList]
        self.allMovies = mockData ?? []
        self.dataModel = mockData
        self.favoriteMovieManager = mockFavoriteMovie
    }
}

extension CinemoViewModel: Service {
    func fetchData() {
        CinemoClient.requestMovieAvailable { [weak self] result in
            switch result {
            case .success(let data):
                self?.allMovies = data.movies
                if let searchText = self?.currentSearchText {
                    self?.search(for: searchText)
                } else {
                    self?.dataModel = data.movies
                }
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
            return dataModel ?? []
        case .favorites:
            let favoriteIDs = favoriteMovieManager.getAllFavorites()
            return dataModel?.filter { favoriteIDs.contains($0.id) } ?? []
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
            model = CinemoCellModel(title: data.titleTh, date: data.releaseDate.formatDate(), genre: data.genre, posterURL: data.posterURL)
        default:
            model = CinemoCellModel(title: data.titleEn, date: data.releaseDate.formatDate(), genre: data.genre, posterURL: data.posterURL)
        }
        return model
    }

    func getHeaderTableTitle() -> String {
        switch self.viewType {
        case .movieList: return Constants.Text.movieFinder.localized()
        case .favorites: return Constants.Text.myFavorite.localized()
        }
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

extension CinemoViewModel {
    func search(for text: String) {
        currentSearchText = text
        if text.isEmpty {
            dataModel = allMovies
        } else {
            dataModel = allMovies.filter { $0.titleEn.contains(text) || $0.titleTh.contains(text) }
        }
    }

    func resetSearch() {
        dataModel = allMovies
    }
}
