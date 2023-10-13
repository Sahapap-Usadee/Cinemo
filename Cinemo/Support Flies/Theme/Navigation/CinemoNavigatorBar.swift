//
//  CinemoNavigatorBar.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

protocol KSNavigatorBarDelegate: AnyObject {
    func didSelectFavoriteButton()
}

enum NavigationBarItemConfiguration {
    case favorite
    case none
}
class CinemoNavigatorBar: UINavigationBar {
    // MARK: Lifecycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    // MARK: Internal

    // MARK: Theme

    weak var actionDelegate: KSNavigatorBarDelegate?

    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setInternalImage(asset: .heartIcon)
        button.addTarget(
            self,
            action: #selector(didSelectFavoriteButton),
            for: .touchUpInside
        )

        return button
    }()

    // MARK: Private

    private let themeManager = ThemeManager.shared.currentTheme
}

extension CinemoNavigatorBar {
    @objc
    func didSelectFavoriteButton() {
        print("*** didSelectFavoriteButton")
        actionDelegate?.didSelectFavoriteButton()
    }
}

extension CinemoNavigatorBar {
    // MARK: Internal

    func setupRightNavigationBarItems(configuration: NavigationBarItemConfiguration) {
        guard let topItem = topItem else { return }
        switch configuration {
        case .favorite:
            let searchButtonItem = UIBarButtonItem(customView: favoriteButton)
            topItem.rightBarButtonItems = [searchButtonItem]
        case .none:
            topItem.rightBarButtonItems = nil
        }
    }

    // MARK: Fileprivate

    func initView() {
        setBackButtonColor()
        let fontColor = themeManager.colors.titleOnTint
        let font = themeManager.fonts.header

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = self.themeManager.colors.main
            appearance.titleTextAttributes = [
                .foregroundColor: fontColor,
                .font: font
            ]
            let backButtonAppearance = UIBarButtonItemAppearance()
            backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
            appearance.backButtonAppearance = backButtonAppearance

            self.standardAppearance = appearance
            self.scrollEdgeAppearance = appearance
        } else {
            titleTextAttributes = [
                .foregroundColor: fontColor,
                .font: font
            ]
            barTintColor = themeManager.colors.main
            let backButtonItem = UIBarButtonItem.appearance()
            backButtonItem.title = ""
        }
    }

    fileprivate func setBackButtonColor() {
        tintColor = themeManager.colors.titleOnTint
    }
}
