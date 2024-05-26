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
    
    var movies: [MovieRemote] = []
    var error: Error?
    var searchQuery = ""

    var searchResult: [MovieRemote] {
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
    
    func fetchMovies() async {
        do {
            let fetchedMovies = try await getMoviesUseCase.getMovies()
            self.movies = fetchedMovies
            print("movies are", movies)
        } catch {
            self.error = error
            print("Failed to decode JSON: \(error)")
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .typeMismatch(_, let context),
                        .valueNotFound(_, let context),
                        .keyNotFound(_, let context),
                        .dataCorrupted(let context):
                    print("Decoding error context: \(context)")
                @unknown default:
                    print("Unknown decoding error")
                }
                print("error is", error)
            }
        }
    }
}
