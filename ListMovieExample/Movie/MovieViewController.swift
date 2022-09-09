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
    var listMovie:[FilmModel] = []
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initViewModel()
    }
    
    private func initViewModel () {
        self.viewModel.binding(delegate: self)
        self.viewModel.interactor.performGetListMovie()
    }
    // MARK: Fetch Movie
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        
    }
    
    // MARK: SetupUI
    private func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CinemaCell.nib, forCellReuseIdentifier: CinemaCell.identifier)
    }
    
    // MARK: IBAction
}

// MARK: Connect View, Interactor, and Presenter
extension MovieViewController: MovieDelegate {
    func didGetListMovie(listMovie: [FilmModel]) {
        self.listMovie = listMovie
        self.tableView.reloadData()
    }
    
}
extension MovieViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovie.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = listMovie[indexPath.row]
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: CinemaCell.identifier) as? CinemaCell else {return UITableViewCell()}
        cell.bindingData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        UITableView.automaticDimension
    }
}

