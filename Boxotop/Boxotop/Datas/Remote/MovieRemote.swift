//
//  MovieRemote.swift
//  Boxotop
//
//  Created by Manon Russo  on 24/05/2024.
//

import Foundation

//struct MovieRemote: Codable {
//    let id = UUID()
//    let title: String
//    let year: String
//    let imdbID: String?
//    let type: String
//    let poster: String
//    let genre: String?
//    let releaseDate: String?
//    let rated: String?
//    let actors: String?
//    let plot: String?
//
//    // CodingKeys to map JSON keys to struct properties
//    enum CodingKeys: String, CodingKey {
//        case title = "Title"
//        case year = "Year"
//        case imdbID = "imdbID"
//        case type = "Type"
//        case poster = "Poster"
//        case genre = "Genre"
//        case releaseDate = "Released"
//        case rated = "Rated"
//        case actors = "Actors"
//        case plot = "Plot"
//    }
//}

struct MovieRemote: Codable {
    let id = UUID()
    let title: String
    let year: String
    let rated: String?
    let released: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let actors: String?
    let plot: String?
    let language: String?
    let country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]?
    let metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let type: String
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let website: String?
    let response: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case imdbID = "imdbID"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
}

extension MovieRemote: Identifiable { }

extension MovieRemote: Hashable { }


// Struct to represent the entire search response
struct SearchResponse: Codable {
    let id = UUID()
    let search: [MovieRemote]
    let totalResults: String
    let response: String

    // CodingKeys to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

extension SearchResponse: Hashable { }

extension SearchResponse: Identifiable { }



struct Rating: Codable {
    let id = UUID()
    let source: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

extension Rating: Hashable { }

extension Rating: Identifiable {}
