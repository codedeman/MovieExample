//
//  TrafficPresenter.swift
//  ListMovieExample
//
//  Created by Pham Kien on 22.08.22.
//

import Foundation
import Alamofire
protocol TrafficLightViewDelegate: NSObjectProtocol {
    func displayTrafficLight(description:(String))
}

class TrafficLightPresenter {
    
    private var trafficLightService:TrafficLightService
    weak private var trafficLightViewDelegate:TrafficLightViewDelegate?
    
    init(trafficLightService:TrafficLightService) {
        self.trafficLightService = trafficLightService
    }
    
    func setViewDelegate(trafficLighViewDelegate:TrafficLightViewDelegate?) {
        self.trafficLightViewDelegate = trafficLighViewDelegate
    }
    
    func trafficLightColorSelected(colorName:String) {
        trafficLightService.getTrafficLight(colorName: colorName) { [weak self] trafficLight in
            if let trafficLight = trafficLight {
                self?.trafficLightViewDelegate?.displayTrafficLight(description: trafficLight.description)
            }
        }
    }
    
    
    
    
}
