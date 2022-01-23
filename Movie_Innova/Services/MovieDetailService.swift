//
//  MovieDetailService.swift
//  Movie_Innova
//
//  Created by Alican Kurt on 23.01.2022.
//

import Foundation

class MovieDetailService {
    // https://www.omdbapi.com/?apikey=c84b1bec&t=batman&plot=full
    static let shared = MovieDetailService()
    
    public func get(with url: URL, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
    
         URLSession.shared.dataTask(with: url) { data, response, err in
             
                         
             if let _ = err {
                 completion(.failure(MovieDetailError.URLError))
             }
             else if let data = data {
                 do {
                     print(data)
                     let search = try JSONDecoder().decode(MovieDetail.self, from: data)
                     //print(search)
                     completion(.success(search))
                 }catch{
                     completion(.failure(MovieDetailError.ParseError))
                 }
             }else{
                 completion(.failure(MovieDetailError.DataError))
             }
             
         }.resume()
         //
     }
    
 }

enum MovieDetailError: Error {
    case URLError
    case DataError
    case ParseError
}
 

