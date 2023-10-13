//
//  AppCaller.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

// MARK: - AppCaller

class AppCaller {
    // MARK: Lifecycle

    init() {
        defaultButtonText = Constants.Button.ok.localized()
        defaultTitleText = ""
    }

    // MARK: Private

    var mainViewController: UIViewController? {
        return mainKeyWindow?.rootViewController
    }

    var mainKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.filter { $0.isKeyWindow }.first
    }

    var topController: UIViewController? {
        var topController = topPresentedViewController()

        if let topNavController = topNavigationController()?.topViewController {
            topController = topNavController
        }
        return topController
    }

    private let themeManager = ThemeManager.shared.currentTheme
    private let defaultButtonText: String
    private let defaultTitleText: String
    private var window: UIWindow? = UIApplication.shared.windows.first
}

// MARK: AlertPresentation

extension AppCaller: AlertPresentation {
    func showAlert(message: String) {
        showAlertController(
            title: defaultTitleText,
            message: message,
            actions: [UIAlertAction(title: defaultButtonText, style: .default)]
        )
    }

    func showAlert(message: String, completion: @escaping (_ result: Bool) -> Void) {
        showAlertController(
            title: defaultTitleText,
            message: message,
            actions: [UIAlertAction(title: defaultButtonText, style: .default) { _ in completion(true) }]
        )
    }


    private func showAlertController(
        title: String?,
        message: String,
        actions: [UIAlertAction]
    ) {
        guard let topController = topController, !(topController is UIAlertController) else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        topController.present(alert, animated: true)
    }
}

// MARK: ViewControllerPresentation

extension AppCaller: ViewControllerPresentation {
    func openCinemoDetail(data: CinemoDetailModel) {
        let model = CinemoDetailViewModel(data: data)
        let viewController = CinemoDetailViewController(viewModel: model)
        viewController.modalPresentationStyle = .fullScreen
        topController?.present(viewController, animated: true, completion: nil)
    }

    func openFavorite() {
        let storyBoard = UIStoryboard(name: "CinemoMain", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: CinemoViewController.identifier) as? CinemoViewController

        if let viewController = viewController {
            viewController.viewModel = .init(type: .favorites)
            topController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}


extension AppCaller {
    // MARK: ViewController Navigation

    private func topNavigationController() -> UINavigationController? {
        var window = mainViewController as? UINavigationController
        if  window != nil {
            while window!.presentedViewController != nil {
                if let current = window!.presentedViewController as? UINavigationController {
                    window = current
                }
            }
        }
        return window
    }

    private func topPresentedViewController() -> UIViewController? {
        var topController = mainViewController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
}
