//
//  CinemoMainViewModel.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Combine

class CinemoMainViewModel {
    // Outputs for the View
    @Published private(set) var dataModel: MovieAvailableResponse?
    @Published private(set) var error: Error?
    var cancellables = Set<AnyCancellable>()
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
