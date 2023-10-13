//
//  CinemoClient.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
enum CinemoClient {
    static func requestMovieAvailable(completion: @escaping (Result<MovieAvailableResponse, Error>) -> Void) {
        APIClient.performRequest(route: CinemoRouter.movieAvailable) { (result: Result<MovieAvailableResponse, Error>) in
            completion(result)
        }
    }
}
