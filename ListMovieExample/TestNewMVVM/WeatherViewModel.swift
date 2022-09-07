//
//  WeatherViewModel.swift
//  ListMovieExample
//
//  Created Pham Kien on 07.09.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation


class WeatherViewModel {
   
    let locationName = Box("")
    var listMovie:Box<[FilmModel]> = Box([])
    //listMovie[22]
    
    init () {
        
    }
    
    public func loadNewLocation(name:String) {
        locationName.value = name
    }
    
    public func loadList() {
        let film:[FilmModel] = [
            FilmModel.init(id: "123", filmUrl: "12334", name: "Kevin", price: "Nghệ An", imageSize: 1234, age: "34",details: FilmDetailsModel()),
            FilmModel.init(id: "123", filmUrl: "12334", name: "Bach The", price: "Cà Mau", imageSize: 1234, age: ""),
            FilmModel.init(id: "123", filmUrl: "12334", name: "Duc", price: "Bạc Liêu", imageSize: 1234, age: "23")
        ]
        listMovie.value = film
    }
    
    public func subscible() {
        
        listMovie.value.forEach { film in
            
        }
    }
    
    
}

