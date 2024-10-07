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
    static let youKey = "AIzaSyABO7HtJxQIdUY6N7MzRchVSRPAq3gmqZQ"
    static let youUrl = "https://youtube.googleapis.com/youtube/v3/search"
}

enum APIError:Error{
    case failedTogetData
}

class APICaller{
    static let shared = APICaller()
    
    
    func getTrendingMovies(complation:@escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complation(.success(results.results))
            }catch{
                complation(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    func getTrendingTvs(complation:@escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complation(.success(results.results))
            }catch{
                complation(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    
    func getMovies(_ searchKey:String, complation:@escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/\(searchKey)?api_key=\(Constants.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complation(.success(results.results))
            }catch{
                complation(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(complation:@escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&inlude_adult=false&inlude_video=false&page=1&with_watch_monitization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complation(.success(results.results))
            }catch{
                complation(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func search(with query:String,complation:@escaping (Result<[Title],Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.apiKey)&query=\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complation(.success(results.results))
            }catch{
                complation(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getMovie(with query:String,complation:@escaping (Result<VideoElement,Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}
        guard let url = URL(string: "\(Constants.youUrl)?q=\(query)&key=\(Constants.youKey)")else{return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                complation(.success(results.items[0]))
                
            }catch{
                complation(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}
