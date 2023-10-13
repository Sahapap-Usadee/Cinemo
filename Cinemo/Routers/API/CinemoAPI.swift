//
//  CinemoAPI.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
public class CinemoAPI {
    // MARK: Lifecycle

    init() {}

    // MARK: Public

    public static var shared = CinemoAPI()

    public var enviroment: String { getConfig()["server_env"] as? String ?? "" }
    public var movieURL: String { getConfig()["movie_URL"] as? String ?? "" }
}

extension CinemoAPI: Logic {
    func queryString(from parameters: [String: Any]?) -> Data? {
        guard let parameters = parameters else {
            return nil
        }

        let queryString = parameters.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        return queryString?.data(using: .utf8)
    }

    func json(from param: [String: Any]?) -> Data? {
        if let param = param {
            do {
                return try JSONSerialization.data(withJSONObject: param, options: [])
            } catch {
                print("Error: cannot create JSON from dictionary.")
                return nil
            }
        }
        return nil
    }
}


extension CinemoAPI {
    private func getConfig() -> NSDictionary {
        guard
            let env = Bundle.configurationEnv,
            let path = Bundle.getPathFile(name: "Configuration"),
            let configFile = NSDictionary(contentsOfFile: path),
            let configDict = configFile[env] as? NSDictionary
        else {
            return NSDictionary()
        }
        return configDict
    }
}
