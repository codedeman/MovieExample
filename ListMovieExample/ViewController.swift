//
//  ViewController.swift
//  ListMovieExample
//
//  Created by Pham Kien on 04.08.22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate,TrafficLightViewDelegate{
  
    
    private let disposeBag = DisposeBag()
     let homeViewModel:HomeViewModel = HomeViewModel()
     var  listMovie:PublishSubject<[FilmModel]> = PublishSubject()
     var listCinema:Observable<[FilmModel]>!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let trafficLightPresenter = TrafficLightPresenter(trafficLightService: TrafficLightService())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tableView.separatorColor = .clear
        self.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableView.automaticDimension
       
        self.tableView.register(CinemaCell.nib, forCellReuseIdentifier: CinemaCell.identifier)
        homeViewModel.getListMovie().subscribe {$0.element.flatMap { filmData in
            self.listMovie.onNext(filmData.listFilms)
            self.listCinema = Observable.of(filmData.listFilms)
        }}.disposed(by: disposeBag)
        
        listMovie.asObservable().bind(to: tableView.rx.items) {(tableView,row,element) in
            let cell:CinemaCell = tableView.dequeueReusableCell(withIdentifier: CinemaCell.identifier) as! CinemaCell
            cell.bindingData(data: element)
            cell.delegate = self
            cell.indexRow = row
            return cell
        }.disposed(by: disposeBag)
        setUpCollectionView()
        
        trafficLightPresenter.setViewDelegate(trafficLighViewDelegate: self)
        trafficLightPresenter.trafficLightColorSelected(colorName: "Red")
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let wSelf = self else {return}
            let vc = PromotionViewController.init(nibName:"PromotionViewController" , bundle: nil)
            wSelf.navigationController?.pushViewController(vc, animated: true)
            
        }
        
         
        // Do any additional setup after loading the view.vie
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return UITableView.automaticDimension
    }
    
    func setUpCollectionView() {
        self.collectionView.register(CinemaPrinterestCell.nib, forCellWithReuseIdentifier: CinemaPrinterestCell.identifier)
        
        
    }
    
    func displayTrafficLight(description: (String)) {
        
        print("description ===== \(description)")
    }

}

extension ViewController:CinemaCellDelegate {
    func loadImageCompleted(index: Int) {
        self.tableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .fade)
    }
}

