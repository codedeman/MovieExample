//
//  PromotionViewModel.swift
//  ListMovieExample
//
//  Created Pham Kien on 22.08.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol PromotionDelegate: NSObject {
    func getListMovive(listMoive:[FilmModel])
    func getTrafficLight(light:TrafficLight)
}

protocol  PromotionViewModelInteractorProtocol {
    var viewModel:PromotionViewModel? {get set}
    func getTrafficLight(colorName:String)
    func getListMovie()
}

class PromotionViewModelDataSource {
    var listMovie:[FilmModel] = []
    
}

class PromotionViewModel: NSObject {
    weak var delegate:PromotionDelegate?
    var interactor = PromotionInteractor()
    var dataSource: PromotionViewModelDataSource = PromotionViewModelDataSource()
    func binding(delegate:PromotionDelegate) {
        self.delegate = delegate
        self.interactor.viewModel = self
    }
    func unbinding(delegate:PromotionDelegate) {
        
    }
    

}


class PromotionInteractor:PromotionViewModelInteractorProtocol {
    var viewModel: PromotionViewModel?
    var listMovie:[FilmModel] = []

    func getListMovie() {
        TrafficLightService.instance.getListMovie { [weak self] filmData in
            guard let wSelf = self else {return}
            wSelf.listMovie = filmData.listFilms
            wSelf.viewModel!.delegate?.getListMovive(listMoive: wSelf.listMovie)
        }
    }
    func getTrafficLight(colorName: String) {
        TrafficLightService.instance.getTrafficLight(colorName: colorName) { [weak self] trafficLight in
            guard let wSelf = self else {return}
            guard let traffic = trafficLight else {return}
            wSelf.viewModel?.delegate?.getTrafficLight(light: traffic)
        }

    }
}
