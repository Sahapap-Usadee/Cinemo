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
    let sampleMovieDetail = CinemoDetailModel(id: 1, title: "Mock Movie", synopsis: "Mock Synopsis", genre: "Mock Genre", posterURL: "https://example.com/mock.jpg")

    override func setUpWithError() throws {
        let mockFavoriteManager = MockFavoriteMovieManager(favorites: [1])
        viewModel = CinemoDetailViewModel(data: sampleMovieDetail, favoriteManager: mockFavoriteManager)
        viewController = CinemoDetailViewController(viewModel: viewModel)
        _ = viewController.view
    }

    func testViewModelInitializationWithMockData() {
        XCTAssertEqual(viewController.viewModel.dataModel, sampleMovieDetail)
    }

    func testFavoriteToggleUpdatesViewModel() {
        XCTAssertEqual(viewModel.isFavorite, true)
        viewModel.toggleFavorite()
        XCTAssertEqual(viewModel.isFavorite, false)
    }

    func testDataWhenSetViewModel() {
        let expectation = XCTestExpectation(description: "Wait for UI Updates")
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewController.titleLabels[0].text, "Mock Genre")
            XCTAssertEqual(self.viewController.titleLabels[1].text, "Mock Movie")
            XCTAssertEqual(self.viewController.titleLabels[2].text, "Mock Synopsis")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
