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
