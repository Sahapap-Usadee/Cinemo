//
//  Bundle+Extension.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
extension Bundle {
    static var configurationEnv: Any? {
        Bundle.main.object(forInfoDictionaryKey: "Configuration")
    }

    static func getPathFile(name: String, type: String = Constants.FileType.plist) -> String? {
        Bundle.main.path(forResource: name, ofType: type)
    }
}
