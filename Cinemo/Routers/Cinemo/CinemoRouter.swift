//
//  CinemoRouter.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Alamofire
import Foundation

// MARK: - KSOneRouter

enum CinemoRouter: APIRouter {
    case movieAvailable


    // MARK: Internal

    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }

    var path: String {
        switch self {
        case .movieAvailable: return "/apis/get_movie_avaiable"
        }
    }

    var headers: [String: String] {
        switch self {
        default:
            return [
                HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue
            ]
        }
    }

    var baseURL: String {
        switch self {
        default: return CinemoAPI.shared.movieURL
        }
    }

    var parameters: Parameters? {
        switch self {
        default: return nil
        }
    }
}
