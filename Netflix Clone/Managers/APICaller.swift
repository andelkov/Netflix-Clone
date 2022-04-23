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
    static let YoutubeAPI_KEY = "AIzaSyAp5Blefta5kJPYzjyariE1dj4iSGhKnpo"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
            guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }

                do {
                    let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(.success(results.results))
                    
                } catch {
                    completion(.failure(APIError.failedTogetData))
                }
            }
            
            task.resume()
        }
        
        
   func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
       guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
       let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
           guard let data = data, error == nil else {
               return
           }

           do {
               let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
               completion(.success(results.results))
           }
           catch {
               completion(.failure(APIError.failedTogetData))
           }
       }
       
       task.resume()
   }
        
        
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print(error.localizedDescription)
            }

        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:"\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from:data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
        
     func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
         guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return }
         let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
             guard let data = data, error == nil else {
                 return
             }
             
             do {
                 let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                 completion(.success(results.results))

             } catch {
                 completion(.failure(APIError.failedTogetData))
             }

         }
         task.resume()
     
     }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
            

            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
            guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                    
                    completion(.success(results.items[0]))
                    

                } catch {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }

            }
            task.resume()
        }
}
