//
//  HomeViewModel.swift
//  Movie_Innova
//
//  Created by Alican Kurt on 23.01.2022.
//

import Foundation

class HomeViewModel{
    
    public func getSearchMovies(searchText: String, completion: @escaping (Result<[MovieModel], MovieError>) -> Void){
        
        var movieArray = [MovieModel]()
        
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=c84b1bec&s=\(searchText)") else{
            completion(.failure(MovieError.URLError))
            return
        }
        
       
        
        MovieSearchService.shared.get(with: url) { result  in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let searchArray):
                //print(searchArray)
                // Parsing Movies
                for search in searchArray.Search!{
                    var title = String()
                    var type = String()
                    var year = String()
                    var poster = String()
                    var imdbID = String()
                    for (key,value) in search{
                        
                        //let title = movie["Title"]
                        //print(movie["Title"])
                        //let dictionary = movie.reduce(into: [:]) { $0[$1.0] = $1.1 }
                        if key == "Title"{
                            title = value
                        }
                        if key == "Type"{
                            type = value
                        }
                        if key == "Year"{
                            year = value
                        }
                        if key == "Poster"{
                            poster = value
                        }
                        if key == "imdbID"{
                            imdbID = value
                        }
                        
                    }
                    var movie = MovieModel(Title: title, Year: year, imdbID: imdbID, Type: type, Poster: poster )
                    movieArray.append(movie)
                }
                
                completion(.success(movieArray))
            }
        }
    }
   
}


enum MovieSearchError: Error {
    case URLError
    case DataError
    case ParseError
}
