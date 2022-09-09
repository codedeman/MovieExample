//
//  WeatherViewController.swift
//  ListMovieExample
//
//  Created Pham Kien on 07.09.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class WeatherViewController:UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var lblWeather: UILabel!
    public var viewModel = WeatherViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    let myConcurrentQueue = DispatchQueue(label: "MyConcurrentQueue", attributes: .concurrent)
        var earths: [String] = []

    var listMovie:[FilmModel]! {
        didSet {
            self.tableView.reloadData()
        }
    }
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchDataOnLoad()
        initViewModel()
    }
    
    private func initViewModel () {
        
        myConcurrentQueue.sync {
            for i in 0...1000 {
                self.earths.append("🌎: \(i)")
            }
        }
        
//        myConcurrentQueue.async {
//            for i in 0...1000 {
////                self.earths[i] = "⚽: \(i)"
//                print(self.earths[i])
//            }
//        }
        myConcurrentQueue.async(flags: .barrier) {
            for i in 0...1000 {
                self.earths[i] = "⚽: \(i)"
                print(self.earths[i])

            }
        }
        
        self.viewModel.loadList()
        
        self.viewModel.locationName.bind { textStr in
            self.lblWeather.text = textStr
        }
        self.viewModel.listMovie.bind { filmModel in
            self.listMovie = filmModel
        }
    }
    // MARK: Fetch Weather
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        
    }
    // MARK: SetupUI
    private func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CinemaCell.nib, forCellReuseIdentifier: CinemaCell.identifier)
    }
    
}

extension WeatherViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovie.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = listMovie[indexPath.row]
        let cell:CinemaCell = tableView.dequeueReusableCell(withIdentifier: CinemaCell.identifier)! as! CinemaCell
        cell.lblTitle.text = data.name
        cell.lblSubtitle.text = data.details?.id
        return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = listMovie[indexPath.row]
//        listMovie[indexPath.row].details?.id.value  = "---LOADING----\(data.name ?? "")"
        viewModel.locationName.value = data.price ?? ""
        viewModel.listMovie.value = listMovie
    }
}
// MARK: Connect View, Interactor, and Presenter
//extension WeatherViewController: WeatherDelegate {
//
//}

