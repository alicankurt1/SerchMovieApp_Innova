//
//  DetailViewModel.swift
//  Movie_Innova
//
//  Created by Alican Kurt on 23.01.2022.
//

import Foundation

class DetailViewModel{
    
    public func getMovieDetail(movieName: String, completion: @escaping (Result<MovieDetail, Error>) -> Void){
        
        
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=c84b1bec&t=\(movieName)&plot=full") else{
            completion(.failure(MovieSearchError.URLError))
            return
        }
        
        MovieDetailService.shared.get(with: url) { result  in
            switch result{
            case .failure(let error):
                print(error)
                completion(.failure(MovieSearchError.DataError))
            case .success(let movieDetail):
                //print(searchArray)
             
                completion(.success(movieDetail))
            }
        }
    }
    enum MovieSearchError: Error {
        case URLError
        case DataError
        case ParseError
    }
    
}


