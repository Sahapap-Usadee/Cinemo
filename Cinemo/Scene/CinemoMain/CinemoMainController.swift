//
//  ViewController.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

class CinemoMainController: UIViewController {
    let viewModel = CinemoMainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }
}

extension CinemoMainController: Service {
    private func bindViewModel() {
        viewModel.$dataModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
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
        print(self.viewModel.dataModel)
    }

    private func handleError(_ error: Error) {
        // Handle the error, e.g., show an alert or an error message on the screen
    }
}
