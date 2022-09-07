//
//  CinemaPrinterestCell.swift
//  ListMovieExample
//
//  Created by Pham Kien on 19.08.22.
//

import UIKit

class CinemaPrinterestCell: UICollectionViewCell {

    @IBOutlet weak var ivCinema: UIImageView!
    
    static let nib = UINib.init(nibName:"\(CinemaPrinterestCell.self)" , bundle: nil)
    static let identifier:String = "\(CinemaPrinterestCell.self)"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
