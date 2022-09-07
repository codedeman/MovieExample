//
//  TrafficLightService.swift
//  ListMovieExample
//
//  Created by Pham Kien on 22.08.22.
//



import Foundation
import Alamofire
struct TrafficLight {
    let colorName: String
    let description: String
}

struct Light {
    
    let colorName:String
    let description: String

}

class TrafficLightService {
    
    typealias FilmDataCallBack = (FilmData) -> Void
   static let instance:TrafficLightService = TrafficLightService()
    
    func getTrafficLight(colorName:(String), callBack:(TrafficLight?) -> Void) {
        let trafficLights = [TrafficLight(colorName: "Red", description: "Stop"),
                             TrafficLight(colorName: "Green", description: "Go"),
                             TrafficLight(colorName: "Yellow", description: "About to change to red")
        ]
        
        let light:Any = trafficLights.first!
        
        if  let finalConver:Light = light as? Light {
            print("Ahahahaah  \(finalConver.colorName)")
        }
        
        if let foundTrafficLight = trafficLights.first(where: {$0.colorName == colorName}) {
            callBack(foundTrafficLight)
        } else {
            callBack(nil)
        }
    }
    
    
    func getListMovie(onSucess:FilmDataCallBack!) {
        let url = "https://codedeman.github.io/ssd_api/fakeCinema.json"
        AF.request(url).validate().responseJSON { response  in
            print("response +++++ ---  \(response.result)")
            do {
                if let data = response.data  {
                    let project = try JSONDecoder().decode(FilmData.self, from: data)
                    onSucess(project)
                }
            } catch {
                
            }
        }
    }
}

