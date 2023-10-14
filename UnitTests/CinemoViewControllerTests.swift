//
//  CinemoTests.swift
//  CinemoTests
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import XCTest
@testable import Cinemo

final class CinemoViewControllerTests: XCTestCase {
    var cinemoViewController: CinemoViewController!
    var sampleMovieList: [MovieAvailable]!

    override func setUpWithError() throws {
        super.setUp()

        // Instantiate CinemoViewController from storyboard
        let storyBoard = UIStoryboard(name: "CinemoMain", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: CinemoViewController.identifier) as? CinemoViewController else {
            XCTFail("Failed to instantiate CinemoViewController from storyboard")
            return
        }
        cinemoViewController = viewController

        // Load sample movie data
        let data = try loadMockData(fileName: "MovieAvailableMock")
        let dataResponse = try JSONDecoder().decode(MovieAvailableResponse.self, from: data)
        sampleMovieList = dataResponse.movies

        // Inject sample movie data into ViewModel
        let viewModel = CinemoViewModel(type: .movieList, mockData: sampleMovieList)
        cinemoViewController.viewModel = viewModel
    }

    override func tearDownWithError() throws {
        cinemoViewController = nil
        sampleMovieList = nil
        super.tearDown()
    }

    func testViewControllerInitializesRequiredProperties() {
        _ = cinemoViewController.view
        XCTAssertNotNil(cinemoViewController.searchMovieBar, "SearchMovieBar should be initialized.")
        XCTAssertNotNil(cinemoViewController.tableView, "TableView should be initialized.")
        XCTAssertNotNil(cinemoViewController.viewModel, "ViewModel should be initialized.")
    }

    func testViewModelLoadsSampleMovies() {
        _ = cinemoViewController.view
        XCTAssertEqual(cinemoViewController.viewModel.dataModel?.count, sampleMovieList.count, "Loaded movie data should match sample data count.")
    }

    func testViewModelFetchesCorrectMovieDetail() {
        let movieDetails = cinemoViewController.viewModel.getMovieDetail(row: 0)
        XCTAssertEqual(movieDetails.title, "Mock Movie", "Movie title should match sample data.")
        XCTAssertEqual(movieDetails.genre, "Mock Genre", "Movie genre should match sample data.")
    }

    func testViewModelFiltersMoviesByTitleSuccessfully() {
        let searchText = "hello"
        cinemoViewController.viewModel.search(for: searchText)
        let filteredMovies = cinemoViewController.viewModel.dataModel
        XCTAssertEqual(filteredMovies?.count, 1, "Only one movie should match the search text.")
        XCTAssertEqual(filteredMovies?.first?.titleEn, searchText, "The title of the filtered movie should match the search text.")
    }

    func testViewModelFiltersFavoriteMoviesCorrectly() {
        let mockFavoriteManager = MockFavoriteMovieManager(favorites: [1, 3])
        let viewModel = CinemoViewModel(type: .favorites, mockData: sampleMovieList, mockFavoriteMovie: mockFavoriteManager)
        let favoriteMovies = viewModel.getMovielist()
        let favoriteMovieTitles = favoriteMovies.map { $0.titleEn }
        XCTAssertEqual(favoriteMovies.count, 2, "Only two movies should be marked as favorites.")
        XCTAssertTrue(favoriteMovieTitles.contains("Mock Movie"), "Mock Movie should be a favorite.")
        XCTAssertTrue(favoriteMovieTitles.contains("hello"), "hello movie should be a favorite.")
    }
}
