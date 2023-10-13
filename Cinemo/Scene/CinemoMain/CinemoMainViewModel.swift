//
//  CinemoMainViewModel.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Combine
import Localize_Swift


class CinemoMainViewModel {
    // Outputs for the View
    @Published private(set) var dataModel: MovieAvailableResponse?
    @Published private(set) var error: Error?
    var cancellables = Set<AnyCancellable>()
    enum Section {
        case movieList
        case none
    }
    let sectionList: [Section]
    init() {
        sectionList = [.movieList]
    }
}

extension CinemoMainViewModel: Service {
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

extension CinemoMainViewModel: Logic {
    func getMovielist() -> [MovieAvailable] {
        dataModel?.movies ?? []
    }

    func getModelMovie(row: Int) -> CinemoCellModel {
        guard let data = dataModel?.movies[row]  else { return CinemoCellModel() }
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

extension CinemoMainViewModel {
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
