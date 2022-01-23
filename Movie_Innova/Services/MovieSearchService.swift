//
//  MovieJsonService.swift
//  Movie_Innova
//
//  Created by Alican Kurt on 23.01.2022.
//

import Foundation

class MovieSearchService {
    
    static let shared = MovieSearchService()
    
    // https://www.omdbapi.com/?apikey=c84b1bec&s=batman
    // https://www.omdbapi.com/?apikey=c84b1bec&t=batman&plot=full
    
   public func get(with url: URL, completion: @escaping (Result<SearchModel, MovieError>) -> Void) {
   
        URLSession.shared.dataTask(with: url) { data, response, err in
            
                        
            if let _ = err {
                completion(.failure(MovieError.URLError))
            }
            else if let data = data {
                do {
                    print(data)
                    let search = try JSONDecoder().decode(SearchModel.self, from: data)
                    print(search.Response)
                    if search.Response == "False" {
                        completion(.failure(MovieError.NotFoundError))
                        return
                    }
                    completion(.success(search))
                }catch{
                    print(data)
                    completion(.failure(MovieError.ParseError))
                }
            }else{
                completion(.failure(MovieError.DataError))
            }
            
        }.resume()
        //
    }
    
}

enum MovieError: Error {
    case URLError
    case DataError
    case ParseError
    case NotFoundError
}
