//
//  ViewController.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit
import Haptica
class CinemoMainController: UIViewController {
    let viewModel = CinemoMainViewModel()
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyTheme()
        bindViewModel()
        self.initTableView()
        initRefreshTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }

    private let themeManager = ThemeManager.shared.currentTheme

    @objc
    func refresh() {
        viewModel.fetchData()
    }
    // MARK: Theme
}

extension CinemoMainController: Themes {
    func applyTheme() {
        view.backgroundColor = themeManager.colors.background
    }
}

extension CinemoMainController: Service {
    private func bindViewModel() {
        viewModel.$dataModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.refreshControl.endRefreshing()
                self?.updateUIWithData()
            }
            .store(in: &viewModel.cancellables)

        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    self?.refreshControl.endRefreshing()
                    self?.handleError(error)
                }
            }
            .store(in: &viewModel.cancellables)
    }
}

extension CinemoMainController: UserInterface {
    private func updateUIWithData() {
        self.tableView.reloadData()
    }

    private func handleError(_ error: Error) {
        AppCaller().showAlert(message: Constants.Alert.sessionError.localized())
    }

    private func initTableView() {
        tableView.setThemeTableView()
        tableView.register(CinemoTableViewCell.self)
        tableView.register(CinemoheaderTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollIndicatorInsets = tableView.contentInset
    }

    private func initRefreshTableView() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

extension CinemoMainController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        Haptic.impact(.medium).generate()
        AppCaller().showAlert(message: "test")
    }
}

extension CinemoMainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.sectionType(section: section) {
        case .movieList:
            let cell: CinemoheaderTableViewCell = tableView.dequeueReusableHeaderFooterView()
            cell.viewModel = .init(model: .init(title: Constants.Text.movieFinder.localized()))
            return cell
        case .none:
            return UIView()
        }
    }

    func numberOfSections(in _: UITableView) -> Int {
        viewModel.numberOfSection()
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sectionType(section: indexPath.section) {
        case .movieList:
            let model = self.viewModel.getModelMovie(row: indexPath.row)
            let cell: CinemoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = .init(model: model)
            return cell
        case .none:
            return UITableViewCell()
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(in: section)
    }
}
