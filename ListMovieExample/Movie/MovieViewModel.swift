//
//  MovieViewModel.swift
//  ListMovieExample
//
//  Created Pham Kien on 22.08.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
protocol MovieDelegate: NSObject {
    
}

protocol  MovieViewModelInteractorProtocol {
    var viewModel:MovieViewModel! {get set}
}

class MovieViewModelDataSource {
    
    
}

class MovieViewModel: NSObject {
    private weak var delegate:MovieDelegate?
    public var interactor = MovieInteractor()
    var dataSource: MovieViewModelDataSource = MovieViewModelDataSource()

    class MovieInteractor:MovieViewModelInteractorProtocol {
        var viewModel: MovieViewModel!

        
    }
    func binding(delegate:MovieDelegate) {
        self.delegate = delegate
        self.interactor.viewModel = self
    }
    func unbinding(delegate:MovieDelegate) {
        
    }
    
    
}

