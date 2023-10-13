//
//  APIClient.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Alamofire
import Foundation

class APIClient {
    static let shared = APIClient()

    private init() {}

    static func performRequest<T: Codable, R: URLRequestConvertible>(
        route: R,
        isLogout: Bool = false,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(route).responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case let .success(value):
                completion(.success(value))
            case .failure:
                let error = self.resolveError(with: response.response?.statusCode, isLogout: isLogout)
                print("*Service Request Error: \(error)")
                completion(.failure(error))
            }
        }
    }

    private static func resolveError(with statusCode: Int?, isLogout: Bool = false) -> Error {
        if isLogout { return NetworkError.unknown }
        switch statusCode {
        case 401:
            return NetworkError.unauthorized
        default:
            if !(NetworkReachabilityManager()?.isReachable ?? false) {
                return NetworkError.noInternet
            }
            return NetworkError.unknown
        }
    }
}
