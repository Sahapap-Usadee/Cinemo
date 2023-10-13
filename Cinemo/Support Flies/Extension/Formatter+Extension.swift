//
//  Formatter+Extension.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
extension String {
    func formatDate() -> String {
        let inputFormatter = DateFormatter()

        // Choose date format based on input string length
        if self.count > 11 {
            inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else {
            inputFormatter.dateFormat = "yyyy-MM-dd"
        }

        guard let date = inputFormatter.date(from: self) else { return "" }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"

        return outputFormatter.string(from: date)
    }
}
