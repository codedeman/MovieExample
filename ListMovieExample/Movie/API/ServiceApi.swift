//
//  ServiceApi.swift
//  ListMovieExample
//
//  Created by Pham Kien on 08.09.22.
//

import Foundation
import Alamofire

class MoviveService {
   static let instance  = MoviveService()
    func getListMovie(completion:@escaping(_ sucess:Bool, _ film:FilmData?)->Void) {
        let url = "https://codedeman.github.io/ssd_api/fakeCinema.json"
        AF.request(url).validate().responseJSON { response  in
            print("response +++++ ---  \(response.result)")
            do {
                if let data = response.data  {
                    let project = try JSONDecoder().decode(FilmData.self, from: data)
                    completion(true,project)
                }
            } catch {
                completion(false,nil)
            }
        }
    }
}

