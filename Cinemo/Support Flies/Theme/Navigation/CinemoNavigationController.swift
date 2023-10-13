//
//  CinemoNavigationController.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit
import Haptica
// MARK: - KSNavigationController

class CinemoNavigationController: UINavigationController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
        if let navBar = navigationBar as? CinemoNavigatorBar {
            navBar.initView()
            navBar.actionDelegate = self
        }
    }

    // MARK: Internal

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

// MARK: UIGestureRecognizerDelegate

extension CinemoNavigationController: UIGestureRecognizerDelegate {}

// MARK: UINavigationControllerDelegate

extension CinemoNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        self.setTitle(title: Constants.Text.cinemo.localized())
        // print("---- navigationController willShow \(viewController) \(animated)")
    }

    func navigationController(
        _: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        //  print("---- navigationController didShow \(viewController) \(animated)")
    }
}

// MARK: KSNavigatorBarDelegate

extension CinemoNavigationController: CinemoNavigatorBarDelegate {
    func didSelectFavoriteButton() {
        Haptic.impact(.medium).generate()
        AppCaller().openFavorite()
    }
}

extension UINavigationController {
    func setTitle(title: String) {
        topViewController?.navigationItem.title = title
    }
}
