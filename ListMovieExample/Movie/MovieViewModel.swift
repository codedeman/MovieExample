//
//  MovieViewModel.swift
//  ListMovieExample
//
//  Created Pham Kien on 22.08.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
protocol MovieDelegate: AnyObject {
    func didGetListMovie(listMovie:[FilmModel])
}

protocol  MovieViewModelInteractorProtocol {
    var viewModel:MovieViewModel! {get set}
    func performGetListMovie()
}

class MovieViewModelDataSource {
    
}
class MovieViewModel: NSObject {
     weak var delegate:MovieDelegate?
    public var interactor = MovieInteractor()
    var dataSource: MovieViewModelDataSource = MovieViewModelDataSource()
    
    func binding(delegate:MovieDelegate) {
        self.delegate = delegate
        self.interactor.viewModel = self
    }
    func unbinding(delegate:MovieDelegate) {
        
    }
    
}
class MovieInteractor:MovieViewModelInteractorProtocol {
    var viewModel: MovieViewModel!
    func performGetListMovie() {
        MoviveService.instance.getListMovie { [weak self] sucess, film in
            guard let wSelf = self,let film = film?.listFilms else {return}
            if sucess {
                wSelf.viewModel.delegate?.didGetListMovie(listMovie: film)
            }
            
        }
    }
    
}



