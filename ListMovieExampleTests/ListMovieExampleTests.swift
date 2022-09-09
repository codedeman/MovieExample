//
//  ListMovieExampleTests.swift
//  ListMovieExampleTests
//
//  Created by Pham Kien on 04.08.22.
//

import XCTest
@testable import ListMovieExample

class ListMovieExampleTests: XCTestCase {
    
    
    var viewModel:MovieViewModel!
    var mockViewController:MockListMoviePresenter!
    var sut:MovieViewController!
    
    override func setUp()  {
        viewModel = MovieViewModel()
        mockViewController = MockListMoviePresenter()
        viewModel.binding(delegate: mockViewController)
        sut = MovieViewController(nibName: "MovieViewController", bundle: nil)
        _ = sut.view
        
        super.setUp()
        
    }
    override  func tearDown() {
        viewModel = nil
        mockViewController = nil
        super.tearDown()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        viewModel.interactor.performGetListTest()
        XCTAssertFalse(self.mockViewController.listMovie.isEmpty)
        let index = self.mockViewController.listMovie.firstIndex(where: {$0.age == "18"}) ?? 0
        XCTAssertEqual(mockViewController.listMovie[index].name, "Spider man")
    }
    func test_loading_ViewController () throws {
        viewModel.interactor.performGetListTest()
        XCTAssertNotNil(sut.tableView)
        XCTAssertTrue(sut.isViewLoaded)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension MovieInteractor {
    
  fileprivate func performGetListTest() {
        let listFilm:[FilmModel] = [
            FilmModel.init(id: "1123", filmUrl: "", name: "Bat man", price: "19292929", imageSize: 0, age: ""),
            FilmModel.init(id: "11234", filmUrl: "", name: "Spider man", price: "1991992", imageSize: 0, age: "18"),
            FilmModel.init(id: "11235", filmUrl: "", name: "Kings Man", price: "19292929", imageSize: 0, age: "18")
        ]
        self.viewModel.delegate?.didGetListMovie(listMovie: listFilm)
    }
    
    
}

final class MockListMoviePresenter:MovieDelegate {
    var listMovie:[FilmModel] = []
    func didGetListMovie(listMovie: [FilmModel]) {
        self.listMovie = listMovie
    }
    
    
}
