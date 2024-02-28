//
//  APIRouter.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Alamofire
import Foundation
protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var baseURL: String { get }
    var parameters: Parameters? { get }
}

extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        let url = try composeURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
 
        if let parameters = parameters, method == .post {
            if headers[HTTPHeaderField.contentType.rawValue] == ContentType.json.rawValue {
                request.httpBody = CinemoAPI.shared.json(from: parameters)
            } else if headers[HTTPHeaderField.contentType.rawValue] == ContentType.xForm.rawValue {
                request.httpBody = CinemoAPI.shared.queryString(from: parameters)
            }
        }

        return request
    }

    private func composeURL() throws -> URL {
        let base = try baseURL.asURL()
        let url = base.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)

        if method == .get, let params = parameters {
            components?.queryItems = params.compactMap { key, value in
                guard let stringValue = value as? String else { return nil }
                return URLQueryItem(name: key, value: stringValue)
            }
        }

        guard let composedUrl = components?.url else {
            throw URLError(.badURL)
        }

        return composedUrl
    }
}
