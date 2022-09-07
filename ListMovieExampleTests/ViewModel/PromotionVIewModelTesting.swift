//
//  PromotionVIewModelTesting.swift
//  ListMovieExampleTests
//
//  Created by Pham Kien on 22.08.22.
//

import XCTest
import Foundation
@testable import ListMovieExample
class PromotionVIewModelTesting: XCTestCase {
    var viewModel:PromotionViewModel?
    var mockInteractor:MockInteractor?
    var sut:PromotionInteractor?
    var mockPresenter:MockPresenter!
    var mockViewModel:MockViewModel?
    override func setUp() {
        viewModel = PromotionViewModel()
        mockPresenter = MockPresenter()
        viewModel?.binding(delegate: mockPresenter!)
        mockInteractor = MockInteractor()
        mockViewModel = MockViewModel()
        mockViewModel?.binding(delegate: mockPresenter!)
        super.setUp()
        
    }
    override  func tearDown() {
        mockInteractor  =  nil
        viewModel = nil
        super.tearDown()
    }
    
    func testGetListMovie() {
        mockInteractor?.getTrafficLight(colorName: "Red")
        XCTAssertTrue(((mockInteractor?.loadingCompleted) != nil))
        XCTAssertEqual(mockPresenter?.light?.description, "Stop")

    }
    func testPresenter() {
        viewModel?.interactor.getTrafficLight(colorName: "Red")
        XCTAssertEqual(mockPresenter?.light?.description, "Stop")
    }
    func testRequest() {
        viewModel?.interactor.getListMovieFake()
        let object =  mockPresenter.listMoive.first
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.age, "13")
        
        
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
      
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockPresenter:NSObject,PromotionDelegate {
    var light:TrafficLight?
    var isLoadCompleted:Bool = false
    var listMoive: [FilmModel] = []
    func getListMovive(listMoive: [FilmModel]) {
        self.isLoadCompleted = true
        self.listMoive = listMoive
    }
    
    func getTrafficLight(light: TrafficLight) {
        self.light = light
    }
}

//class MockViewModel

protocol PromotionMockingTest:PromotionViewModelInteractorProtocol {
    var viewModelMocking:MockViewModel? {get set}
}
class MockInteractor:PromotionMockingTest {
    
    var viewModelMocking: MockViewModel?
    var viewModel: PromotionViewModel?
    var loadingCompleted = false
    var interactor:PromotionViewModelInteractorProtocol!
    func getTrafficLight(colorName: String) {
        TrafficLightService.instance.getTrafficLight(colorName: colorName) { [weak self] light in
            guard let wself = self else {return}
            wself.loadingCompleted = true
        }
    }
    
    func getListMovie() {
        TrafficLightService.instance.getListFakeMovie { [weak self] filmData in
            guard let wSelf = self else {return}
            wSelf.viewModel?.delegate?.getListMovive(listMoive: filmData.listFilms)
        }
    }
}

extension TrafficLightService {
    func getListFakeMovie(onScucess:FilmDataCallBack) {
        let filmData = FilmData()
        filmData.listFilms = [
            FilmModel.init(id: "1123", filmUrl: "", name: "Bat man", price: "19292929", imageSize: 0, age: "13"),
            FilmModel.init(id: "11234", filmUrl: "", name: "Spider man", price: "1991992", imageSize: 0, age: "18"),
            FilmModel.init(id: "11235", filmUrl: "", name: "Kings Man", price: "19292929", imageSize: 0, age: "16")
        ]
        onScucess(filmData)
    }
}

extension PromotionInteractor {
    func getListMovieFake() {
        TrafficLightService.instance.getListFakeMovie { [weak self] filmData in
            guard let wSelf = self else {return}
            wSelf.viewModel?.delegate?.getListMovive(listMoive: filmData.listFilms)
        }
    }
}
