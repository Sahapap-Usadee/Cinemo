//
//  CinemoDetailViewController.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit
import Haptica

class CinemoDetailViewController: UIViewController {
    private let themeManager = ThemeManager.shared.currentTheme
    public var viewModel: CinemoDetailViewModel
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        applyTheme()
    }

    @IBAction func touchClose(_ sender: UIButton) {
        Haptic.impact(.medium).generate()
        dismiss(animated: true)
    }
    @IBOutlet weak var movieImageView: UIImageView!

    @IBAction func touchFavorite(_ sender: UIButton) {
    }
    required init(viewModel: CinemoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: CinemoDetailViewController.identifier, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CinemoDetailViewController: Themes {
    func applyTheme() {
        view.backgroundColor = themeManager.colors.background
        self.movieImageView.setThemeView(roundType: .roundDefault)
        closeButton.setInternalImage(asset: .closeIcon)
        titleLabels.forEach {
            switch $0.tag {
            case 0: $0.setThemeLabel(font: self.themeManager.fonts.subHeader, textColor: self.themeManager.colors.headerTitle)
            case 1: $0.setThemeLabel(font: self.themeManager.fonts.header, textColor: self.themeManager.colors.title)
            case 2: $0.setThemeLabel(font: self.themeManager.fonts.body, textColor: self.themeManager.colors.title)
            default: break
            }
        }
    }
}

extension CinemoDetailViewController: Service {
    private func bindViewModel() {
        viewModel.$dataModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.updateUIWithData(data: data)
            }
            .store(in: &viewModel.cancellables)
    }
}

extension CinemoDetailViewController: UserInterface {
    private func updateUIWithData(data: CinemoDetailModel) {
        self.movieImageView.setImageFromURL(url: data.posterURL, resize: .scaleAspectFit)
        titleLabels.forEach {
            switch $0.tag {
            case 0: $0.text = data.genre
            case 1: $0.text = data.title
            case 2: $0.text = data.synopsis
            default: break
            }
            favoriteButton.setAddFavoriteButton()
        }
    }
}
