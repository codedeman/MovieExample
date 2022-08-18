//
//  FilmModel.swift
//  ListMovieExample
//
//  Created by Pham Kien on 12.08.22.
//

import Foundation
import UIKit
class FilmData:Codable {
    var listFilms:[FilmModel]!
}
class FilmModel:Codable{
    
    var id:String?
    var filmUrl:String?
    var name:String?
    var price:String?
    var imageSize:Float?
    
//    "id":"12345",
//    "filmUrl":"https://billboardvn.vn/wp-content/uploads/2019/04/Dua-Lipa-elle-cover-2019-billboard-1240.jpg",
//    "name":"Doraemon và những người bạn",
//    "price":"100000"
}
