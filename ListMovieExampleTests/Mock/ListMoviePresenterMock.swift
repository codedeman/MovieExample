//
//  ListMoviePresenterMock.swift
//  ListMovieExampleTests
//
//  Created by Pham Kien on 24.08.22.
//

import Foundation
@testable import ListMovieExample
class PromotionMockPresenter:PromotionPresenter {
    func onViewLoaded() {
        
        
    }
    
    func onEdit() {
        
    }
    
    
    
}

class MockViewModel:PromotionViewModel {
    var mockInteractor:MockInteractor?
    override func binding(delegate: PromotionDelegate) {
        self.delegate = delegate
        self.mockInteractor?.viewModelMocking = self
    }
    
    
}





