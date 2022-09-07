//
//  MovieViewController.swift
//  ListMovieExample
//
//  Created Pham Kien on 22.08.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class MovieViewController:UIViewController {
    
    // MARK: IBOutlet
    
    public var viewModel = MovieViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchDataOnLoad()
        initViewModel()
    }
    
    private func initViewModel () {
        self.viewModel.binding(delegate: self)
        self.viewModel.interactor
    }
    // MARK: Fetch Movie
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        
    }
    
    // MARK: SetupUI
    private func setupView() {
        
    }
    
    // MARK: IBAction
}

// MARK: Connect View, Interactor, and Presenter
extension MovieViewController: MovieDelegate {
    
}

