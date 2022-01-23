//
//  SearchModel.swift
//  Movie_Innova
//
//  Created by Alican Kurt on 23.01.2022.
//

import Foundation

struct SearchModel : Decodable {
    let Search: [[String: String]]?
    let totalResults: String?
    let Response: String
    let Error: String?
}
