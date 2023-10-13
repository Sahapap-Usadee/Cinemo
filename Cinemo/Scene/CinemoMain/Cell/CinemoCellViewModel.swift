//
//  CinemoCellViewModel.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
class CinemoCellViewModel {
    init(model: CinemoCellModel) {
        self.dataModel = model
    }

    private(set) var dataModel: CinemoCellModel
}
