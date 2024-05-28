//
//  MoviesListViewModel.swift
//  Boxotop
//
//  Created by Manon Russo  on 24/05/2024.
//

import Foundation
import Observation

@Observable
final class MoviesListViewModel {
    private let getMoviesUseCase: _GetMoviesUseCase
    
    var movies: [Movie] = []
    var error: Error?
    var searchQuery = ""
    var isLoading = false
    var searchResult: [Movie] {
        guard !searchQuery.isEmpty else {
            return movies
        }

        return movies
            .filter { movie in
                movie.title.contains(searchQuery)
            }
    }

    init(getMoviesUseCase: _GetMoviesUseCase = InjectorUtilities.shared.getMoviesUseCase) {
        self.getMoviesUseCase = getMoviesUseCase
    }
    
    @MainActor
    func fetchMovies() async {
        self.isLoading = true
        do {
            let fetchedMovies = try await getMoviesUseCase.getMovies()
            self.movies = fetchedMovies
        } catch {
            self.error = error
        }
        self.isLoading = false
    }
}
