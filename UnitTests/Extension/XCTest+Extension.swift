//
//  XCTest+Extension.swift
//  CinemoTests
//
//  Created by sahapap usadee on 14/10/2566 BE.
//

import Foundation
import XCTest

extension XCTestCase {
    func loadMockData(fileName: String, fileExtension: String = "json") throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: fileExtension) else {
            throw NSError(domain: "Test", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL for resource \(fileName).\(fileExtension) not found."])
        }
        return try Data(contentsOf: url)
    }
}
