//
//  GetMoviesUseCase.swift
//  Boxotop
//
//  Created by Manon Russo  on 24/05/2024.
//

import Foundation

protocol _GetMoviesUseCase {
    func getMovies() async throws -> [Movie]
}

final class GetMoviesUseCase: _GetMoviesUseCase {
    
    private let movieRepository: _MovieRepository
    
    init(movieRepository: _MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func getMovies() async throws -> [Movie] {
        return try await movieRepository.getMovies()
    }
}
