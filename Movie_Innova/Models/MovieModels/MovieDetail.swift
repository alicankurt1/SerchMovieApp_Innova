//
//  MovieDetail.swift
//  Movie_Innova
//
//  Created by Alican Kurt on 23.01.2022.
//

import Foundation

struct MovieDetail : Decodable {
    let Title : String
    let Actors: String
    let Country: String
    let Director: String
    let Year : String
    let Ratings: [[String: String]]?
    let Poster: String
}
