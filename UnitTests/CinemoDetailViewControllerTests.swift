//
//  CinemoDetailViewControllerTests.swift
//  CinemoTests
//
//  Created by sahapap usadee on 14/10/2566 BE.
//

import XCTest
@testable import Cinemo
final class CinemoDetailViewControllerTests: XCTestCase {
    var viewController: CinemoDetailViewController!
    var viewModel: CinemoDetailViewModel!
    let mockMovie = CinemoDetailModel(id: 1, title: "Mock Movie", synopsis: "Mock Synopsis", genre: "Mock Genre", posterURL: "https://example.com/mock.jpg")

    override func setUpWithError() throws {
        let mockFavoriteManager = MockFavoriteMovieManager(favorites: [1])
        viewModel = CinemoDetailViewModel(data: mockMovie, favoriteManager: mockFavoriteManager)
        viewController = CinemoDetailViewController(viewModel: viewModel)
        _ = viewController.view
    }

    func testInitialization() {
        XCTAssertEqual(viewController.viewModel.dataModel, mockMovie)
    }

    func testUIUpdatesBasedOnViewModel() {
        XCTAssertEqual(viewModel.isFavorite, true)
        viewModel.toggleFavorite()
        XCTAssertEqual(viewModel.isFavorite, false)
    }

    // Add more tests for other interactions and behaviors.
}
