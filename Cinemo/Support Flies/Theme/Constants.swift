//
//  Constants.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
struct Constants {
    enum Text {
    }

    enum Title {
        static let ksBreakingNews = "ksBreakingNews"
    }

    enum Button {
        static let ok = "ok"
        static let cancel = "cancel"
        static let confirm = "confirm"
    }

    enum Alert {
        static let logoutConfirmation = "logoutConfirmation"
        static let sessionExpired = "sessionExpired"
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
