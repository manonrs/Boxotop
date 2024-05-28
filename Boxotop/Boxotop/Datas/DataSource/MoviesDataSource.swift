//
//  MoviesDataSource.swift
//  Boxotop
//
//  Created by Manon Russo  on 24/05/2024.
//

import Foundation

protocol MoviesDataSource {
    func fetchMoviesCurrentlyInFRTheater() async throws -> [Movie]
}

final class MoviesRemoteDataSource: MoviesDataSource {
    
    private let decoder = JSONDecoder()
    
    // OMDb API doesn't provide list for movies currently in box office so I hardlisted it
    private let moviesCurrentlyInTheaterInFrance: [String] = [
        "Furiosa",
        "Kingdom of the Planet of the Apes",
        "Kung Fu Panda 4",
        "Godzilla x Kong",
        "Dune",
        "Ghostbusters",
        "Challengers",
        "Civil War",
        "Frères",
        "Ducobu passe au vert"
    ]

    init() { }
        
    func fetchMoviesCurrentlyInFRTheater() async throws -> [Movie] {
        var movies: [Movie] = []
        let dispatchGroup = DispatchGroup()
        
        for movie in moviesCurrentlyInTheaterInFrance {
            dispatchGroup.enter()
            
            guard let baseURL = Constants.baseURL else {
                throw URLError(.badURL)
            }
            
            var queryItems = [URLQueryItem]()
            queryItems.append(URLQueryItem(name: "y", value: "2024"))
            queryItems.append(URLQueryItem(name: "t", value: "\(movie)"))
            queryItems.append(URLQueryItem(name: "p", value: "1"))
            queryItems.append(URLQueryItem(name: "type", value: "movie"))
//            queryItems.append(URLQueryItem(name: "r", value: "json"))
            
           
            var url = baseURL
            url.append(queryItems: queryItems)
            let (data, _) = try await URLSession.shared.data(from: url)
//             Debugging helper
            
            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON response: \(jsonString)")
            }
            do {
                let searchResponse = try decoder.decode(Movie.self, from: data)
                movies.append(searchResponse)
                //                }
            } 
            dispatchGroup.leave()
        }
        return movies
    }
}
