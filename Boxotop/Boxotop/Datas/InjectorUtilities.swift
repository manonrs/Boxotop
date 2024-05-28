//
//  InjectorUtilities.swift
//  Boxotop
//
//  Created by Manon Russo  on 24/05/2024.
//

import Foundation

final class InjectorUtilities {
    static let shared = InjectorUtilities()

    private init() { }

    // MARK: - Datasources
    private lazy var movieDataSource: MoviesDataSource = MoviesRemoteDataSource()

    // MARK: - Repositories
    private lazy var movieRepository: _MovieRepository = MovieRepository(datasource: movieDataSource)

    
    // MARK: - UseCases
    lazy var getMoviesUseCase: _GetMoviesUseCase = GetMoviesUseCase(movieRepository: movieRepository)
}
