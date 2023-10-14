//
//  CinemoTests.swift
//  CinemoTests
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import XCTest
@testable import Cinemo

final class CinemoViewControllerTests: XCTestCase {
    var viewControllerUnderTest: CinemoViewController!
    var sampleMovies: [MovieAvailable]!

    override func setUpWithError() throws {
        super.setUp()

        // Instantiate CinemoViewController from storyboard
        let storyBoard = UIStoryboard(name: "CinemoMain", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: CinemoViewController.identifier) as? CinemoViewController else {
            XCTFail("Failed to instantiate CinemoViewController from storyboard")
            return
        }
        viewControllerUnderTest = viewController

        // Load sample movie data
        let data = try loadMockData(fileName: "MovieAvailableMock")
        let dataResponse = try JSONDecoder().decode(MovieAvailableResponse.self, from: data)
        sampleMovies = dataResponse.movies

        // Inject sample movie data into ViewModel
        let viewModel = CinemoViewModel(type: .movieList, mockData: sampleMovies)
        viewControllerUnderTest.viewModel = viewModel
    }

    override func tearDownWithError() throws {
        viewControllerUnderTest = nil
        sampleMovies = nil
        super.tearDown()
    }


    func test_ViewController_PropertiesAreInitialized() throws {
        // Ensure view loads
        _ = viewControllerUnderTest.view

        // Check properties
        XCTAssertNotNil(viewControllerUnderTest.searchMovieBar, "SearchMovieBar should be initialized.")
        XCTAssertNotNil(viewControllerUnderTest.tableView, "TableView should be initialized.")
        XCTAssertNotNil(viewControllerUnderTest.viewModel, "ViewModel should be initialized.")
    }

    func test_ViewController_LoadsSampleMovieData() throws {
        // Ensure view loads
        _ = viewControllerUnderTest.view

        // Assuming viewModel exposes dataModel to be publicly readable
        XCTAssertEqual(viewControllerUnderTest.viewModel.dataModel?.count, sampleMovies.count, "Loaded movie data should match sample data count.")
    }

    func test_ViewController_FetchMovieDetails() throws {
        // Fetch movie details for the first movie
        let movieDetails = viewControllerUnderTest.viewModel.getMovieDetail(row: 0)

        // Check the details
        XCTAssertEqual(movieDetails.title, "Mock Movie", "Movie title should match sample data.")
        XCTAssertEqual(movieDetails.genre, "Mock Genre", "Movie genre should match sample data.")
    }

    func test_ViewModel_FiltersMoviesByTitle() throws {
        // Given
        let searchText = "hello"

        // When
        viewControllerUnderTest.viewModel.search(for: searchText)
        let filteredMovies = viewControllerUnderTest.viewModel.dataModel

        // Then
        XCTAssertEqual(filteredMovies?.count, 1, "Only one movie should match the search text.")
        XCTAssertEqual(filteredMovies?.first?.titleEn, searchText, "The title of the filtered movie should match the search text.")
    }

    func test_ViewModel_FiltersFavoriteMovies() throws {
        // Given
        let mockFavoriteManager = MockFavoriteMovieManager(favorites: [1, 3])
        let viewModel = CinemoViewModel(type: .favorites, mockData: sampleMovies, mockFavoriteMovie: mockFavoriteManager)

        // When
        let favoriteMovies = viewModel.getMovielist()

        // Then
        let favoriteMovieTitles = favoriteMovies.map { $0.titleEn }
        XCTAssertEqual(favoriteMovies.count, 2, "Only two movies should be marked as favorites.")
        XCTAssertTrue(favoriteMovieTitles.contains("Mock Movie"), "Mock Movie should be a favorite.")
        XCTAssertTrue(favoriteMovieTitles.contains("hello"), "hello movie should be a favorite.")
    }
}
