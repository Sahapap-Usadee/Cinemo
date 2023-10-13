//
//  CinemoheaderTableViewCell.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

class CinemoheaderTableViewCell: UITableViewHeaderFooterView {
    private let themeManager = ThemeManager.shared.currentTheme

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
    }

    public var viewModel: CinemoHeaderCellViewModel? {
        didSet {
            onUpdated()
        }
    }
}

extension CinemoheaderTableViewCell: Themes {
    func applyTheme() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        self.titleLabel.setThemeLabel(font: self.themeManager.fonts.header, textColor: self.themeManager.colors.subTitle)
    }
}

extension CinemoheaderTableViewCell: UserInterface {
    private func onUpdated() {
        guard let dataModel = viewModel?.dataModel else { return }
        self.titleLabel.text = dataModel.title
    }
}
