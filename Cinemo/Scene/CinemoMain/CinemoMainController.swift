//
//  ViewController.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

class CinemoMainController: UIViewController {
    let viewModel = CinemoMainViewModel()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyTheme()
        bindViewModel()
        self.initTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }
    private let themeManager = ThemeManager.shared.currentTheme
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
                self?.updateUIWithData()
            }
            .store(in: &viewModel.cancellables)

        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
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
        // Handle the error, e.g., show an alert or an error message on the screen
    }

    private func initTableView() {
        tableView.setThemeTableView()
        tableView.register(CinemoTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
}

extension CinemoMainController: UITableViewDataSource, UITableViewDelegate {
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
