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
    var cancellables = Set<AnyCancellable>()

    init(data: CinemoDetailModel) {
        self.dataModel = data
    }
}

// extension CinemoMainViewModel:  {
//    func fetchData() {
//        CinemoClient.requestMovieAvailable { [weak self] result in
//            switch result {
//            case .success(let data):
//                self?.dataModel = data
//            case .failure(let apiError):
//                self?.error = apiError
//            }
//        }
//    }
// }
