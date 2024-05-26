//
//  MovieRepository.swift
//  Boxotop
//
//  Created by Manon Russo  on 24/05/2024.
//

import Foundation

protocol _MovieRepository {
    func getMovies() async throws -> [MovieRemote]
}

final class MovieRepository: _MovieRepository {
    
    private let datasource: MoviesDataSource

    init(datasource: MoviesDataSource) {
        self.datasource = datasource
    }

    func getMovies() async throws -> [MovieRemote] {
        return try await datasource.fetchMoviesCurrentlyInFRTheater()
    }
}
