//
//  CinemoHeaderCellViewModel.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
class CinemoHeaderCellViewModel {
    init(model: CinemoHeaderCellModel) {
        self.dataModel = model
    }

    private(set) var dataModel: CinemoHeaderCellModel
}
