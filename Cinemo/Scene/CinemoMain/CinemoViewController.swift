//
//  ViewController.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit
import Haptica
class CinemoViewController: UIViewController {
    var viewModel: CinemoViewModel = .init()
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        bindViewModel()
        initTableView()
        initRefreshTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
        self.tableView.reloadWithoutAnimation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initNavigation()
    }

    private let themeManager = ThemeManager.shared.currentTheme

    @objc
    func refresh() {
        viewModel.fetchData()
    }
    // MARK: Theme
}

extension CinemoViewController: Themes {
    func applyTheme() {
        view.backgroundColor = themeManager.colors.background
    }
}

extension CinemoViewController: Service {
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

extension CinemoViewController: UserInterface {
    private func updateUIWithData() {
        self.tableView.reloadWithoutAnimation()
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

    private func initNavigation() {
        switch viewModel.viewType {
        case .movieList:
            NavigationBarManager.configure(rightNavBar: .favorite, on: self)
        case .favorites:
            NavigationBarManager.configure(rightNavBar: .none, on: self)
        }
    }
}

extension CinemoViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        Haptic.impact(.medium).generate()
        let data = self.viewModel.getMovieDetail(row: indexPath.row)
        AppCaller().openCinemoDetail(data: data)
    }
}

extension CinemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.sectionType(section: section) {
        case .movieList:
            let cell: CinemoheaderTableViewCell = tableView.dequeueReusableHeaderFooterView()
            cell.viewModel = .init(model: .init(title: self.viewModel.getHeaderTableTitle()))
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
