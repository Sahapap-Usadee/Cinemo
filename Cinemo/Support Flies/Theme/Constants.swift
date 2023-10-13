//
//  Constants.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
struct Constants {
    enum Text {
        static let viewMore = "viewMore"
        static let cinemo = "cinemo"
        static let movieFinder = "movieFinder"
    }

    enum Button {
        static let ok = "ok"
        static let addFavorite = "addFavorite"
        static let removeFavorite = "removeFavorite"
    }

    enum Alert {
        static let sessionError = "sessionError"
    }

    enum Language {
        enum Key: String {
            case english = "en"
            case thai = "th"
        }

        static let english = "English"
        static let thai = "Thai"
    }

    enum FileType {
        static let plist = "plist"
    }
}

enum ConfigurationEnv: String {
    case debug = "Debug"
    case release = "Release"
}
