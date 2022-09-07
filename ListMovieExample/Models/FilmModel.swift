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

enum AgeRetriction:String {
    case C13 = "13"
    case C16 = "16"
    case C18 = "18"
    case SutableAll = "0"
    
    func getBanText()->String {
        switch self {
        case .C18:
            return "18+"
        case .C13:
            return "13+"
        case .C16:
            return "16+"
        case .SutableAll:
            return ""
        }
    }
    
}

class FilmDetailsModel:Codable{
    var id:String? 
}

class FilmModel:Codable{
    var id:String?
    var filmUrl:String?
    var name:String?
    var price:String?
    var imageSize:Float?
    var age:String?
    var details: FilmDetailsModel?
    
    init(id:String,
         filmUrl:String,
         name:String,
         price:String,
         imageSize:Float,
         age:String,
         details:FilmDetailsModel? = nil
    ) {
        self.id = id
        self.filmUrl = filmUrl
        self.price = price
        self.age = age
        self.name = name
        self.details = details
    }
}
