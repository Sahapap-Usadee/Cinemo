//
//  Network.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
import Alamofire
extension Data {
    var prettyString: NSString? { NSString(data: self, encoding: String.Encoding.utf8.rawValue) }
}

// MARK: - ContentType

enum ContentType: String {
    case json = "application/json"
    case xForm = "application/x-www-form-urlencoded"
    case pdf = "application/pdf"
    case close
}

// MARK: - HTTPHeaderField

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case token = "Token"
    case userID = "User-id"
    case acceptEncoding = "Accept-Encoding"
    case connection = "Connection"
    case userAgent = "User-Agent"
    case contentLength = "Content-Length"
}

// MARK: - NetworkError

public enum NetworkError: Error {
    // MARK: - Internal errors

    case noInternet

    // MARK: - API errors

    case badAPIRequest

    // MARK: - Auth errors

    case unauthorized

    case internalServerError

    // MARK: - Unknown errors

    case unknown
}
