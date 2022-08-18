//
//  CinemaCell.swift
//  ListMovieExample
//
//  Created by Pham Kien on 04.08.22.
//

import UIKit
import SDWebImage
protocol CinemaCellDelegate:AnyObject {
    func loadImageCompleted(index:Int)
}
class CinemaCell: UITableViewCell {
    
    static let nib = UINib.init(nibName:"\(CinemaCell.self)" , bundle: nil)
    static let identifier:String = "\(CinemaCell.self)"
    @IBOutlet weak var ivFilm: UIImageView!
    @IBOutlet weak var btnBooking: UIButton!
    @IBOutlet weak var vMain: UIView!
    @IBOutlet weak var vBoard: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var cImageHeight: NSLayoutConstraint!
    
    var indexRow:Int!
    weak var delegate:CinemaCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.vMain.backgroundColor = .white
        self.vBoard.layer.cornerRadius = 10
        self.vBoard.clipsToBounds = true
        self.vMain.layer.cornerRadius = 10
        self.vMain.clipsToBounds = true
        self.vMain.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        self.vMain.layer.borderWidth = 1
        self.lblTitle.textColor = .black
        self.lblSubtitle.textColor = .black
        self.ivFilm.layer.cornerRadius = 10
        self.ivFilm.clipsToBounds = true
        self.btnBooking.layer.cornerRadius = 20
        self.btnBooking.clipsToBounds = true
        // Initialization code
    }
    
    func bindingData(data:FilmModel) {
        self.lblTitle.text = data.name
        self.lblSubtitle.text = data.price
        
        let queue = DispatchQueue(label: "loadimage")
        
        self.ivFilm.sd_setImage(with: URL(string: data.filmUrl ?? "")) { [weak self] image, error, cache, url in
                  guard let wSelf = self else {return}
                  let imageHeight = wSelf.getAspectRatioAccording(image?.size ?? CGSize(width: UIScreen.main.bounds.size.width-20*2, height: 300))
                  data.imageSize = imageHeight
                  wSelf.cImageHeight.constant = CGFloat(imageHeight)
                  if let delegate = wSelf.delegate {
                      delegate.loadImageCompleted(index: wSelf.indexRow)
                  }
              }
//        guard let url = URL(string: data.filmUrl ) else { return  }
//        let session = URLSession.shared
//        let task = session.dataTask(with: url) { [weak self] data, _, _ in
//
//            guard let weakSelf = self else {return}
//            guard let ivData = data else {return}
//            DispatchQueue.main.sync {
//                weakSelf.ivFilm.image  = UIImage(data: ivData)
//                let imgHeight = weakSelf.getAspectRatioAccording(<#T##imageSize: CGSize##CGSize#>)
//                weakSelf.delegate.loadImageCompleted(index: weakSelf.indexRow)
//                print("End job")
//            }
//        }
//        task.resume()
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func  getAspectRatioAccording(_ imageSize:CGSize) ->Float {
          let  aspectRatio = imageSize.height / imageSize.width
          let targetWith = UIScreen.main.bounds.size.width-20*2 // kích thước 2 bên
          let targetHeight = (targetWith * aspectRatio)
          return Float(targetHeight)
      }
    
}
