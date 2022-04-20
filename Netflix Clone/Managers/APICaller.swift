//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Anđelko on 20.Apr.22.
//

import Foundation

struct Constants {
    static let API_KEY = "ff4191d798ff2e423dd93593e2be6b42"
    static let baseURL = "https://api.themoviedb.org"
    
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (String) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error  in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try  JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
}
