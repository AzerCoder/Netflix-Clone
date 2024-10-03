//
//  APICaller.swift
//  Netflix
//
//  Created by A'zamjon Abdumuxtorov on 03/10/24.
//

import Foundation


struct Constants{
    static let apiKey = "38e7765d6ed9dc334baef8e47ba04752"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError:Error{
    case failedTogetData
}

class APICaller{
    static let shared = APICaller()
    
    
    func getTrendingMovies(complation:@escaping (Result<[Movie],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                complation(.success(results.results))
            }catch{
                complation(.failure(error))
               
            }
        }
        task.resume()
    }
    
    
    func getTrendingTvs(complation:@escaping (Result<[String],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                
            }catch{
                complation(.failure(error))
               
            }
        }
        task.resume()
    }
}
