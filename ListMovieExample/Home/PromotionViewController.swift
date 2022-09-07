//
//  PromotionViewController.swift
//  ListMovieExample
//
//  Created Pham Kien on 22.08.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

protocol  PromotionPresenter:AnyObject{
    func onViewLoaded()
    func onEdit()
}

class PromotionViewController:UIViewController {
    
    // MARK: IBOutlet
    
    public var viewModel = PromotionViewModel()
    weak var presenter:PromotionPresenter!
    var listMovie:[FilmModel]!
    public var isScucess:Bool?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listMovie = []
        setupView()
        fetchDataOnLoad()
        initViewModel()
        self.view.backgroundColor = .red
    }
    
    deinit {
        debugPrint("deinit --- \(self) \(viewModel)")
    }
    private func initViewModel () {
        self.viewModel.binding(delegate: self)
        self.viewModel.interactor.getTrafficLight(colorName: "Red")
        self.viewModel.interactor.getListMovie()
    }
    // MARK: Fetch Promotion
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        
    }
    
    // MARK: SetupUI
    private func setupView() {
        
    }
    
    // MARK: IBAction
}

// MARK: Connect View, Interactor, and Presenter
extension PromotionViewController: PromotionDelegate {
    func getTrafficLight(light: TrafficLight) {
        
    }
    
    func getListMovive(listMoive: [FilmModel]) {
        self.listMovie = listMoive
        self.isScucess = true
    }
    
    
    
}

