//
//  CinemoTableViewCell.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

class CinemoTableViewCell: UITableViewCell {
    private let themeManager = ThemeManager.shared.currentTheme
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet weak var cardView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
    }
    public var viewModel: CinemoCellViewModel? {
        didSet {
            onUpdated()
        }
    }
}

extension CinemoTableViewCell: Themes {
    func applyTheme() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        cardView.setThemeView(backgroundColor: themeManager.colors.card, roundType: .roundDefault)
        movieImageView.setThemeView(roundType: .roundDefault)
        titleLabels.forEach {
            switch $0.tag {
            case 0: $0.setThemeLabel(font: self.themeManager.fonts.subHeader, textColor: self.themeManager.colors.headerTitle)
            case 1: $0.setThemeLabel(font: self.themeManager.fonts.header, textColor: self.themeManager.colors.title)
            case 2: $0.setThemeLabel(font: self.themeManager.fonts.dataTitle, textColor: self.themeManager.colors.headerTitle)
            case 3: $0.setThemeLabel(font: self.themeManager.fonts.title, textColor: self.themeManager.colors.subTitle)
            default: break
            }
        }
    }
}

extension CinemoTableViewCell: UserInterface {
    private func onUpdated() {
        guard let dataModel = viewModel?.dataModel else { return }
        movieImageView.setImageFromURL(url: dataModel.posterURL)
        titleLabels.forEach {
            switch $0.tag {
            case 0: $0.text = dataModel.genre
            case 1: $0.text = dataModel.title
            case 2: $0.text = dataModel.date
            case 3: $0.text = Constants.Text.viewMore.localized()
            default: break
            }
        }
    }
}
