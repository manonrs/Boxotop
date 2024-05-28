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
            print("movies are", movies)
        } catch {
            print("errors are")
            self.error = error
            print(error.localizedDescription)
            print(error)
            print("Failed to decode JSON: \(error)")
//            if let decodingError = error as? DecodingError {
//                switch decodingError {
//                case .typeMismatch(_, let context),
//                        .valueNotFound(_, let context),
//                        .keyNotFound(_, let context),
//                        .dataCorrupted(let context):
//                    print("Decoding error context: \(context)")
//                @unknown default:
//                    print("Unknown decoding error")
//                }
//                print("error is", error)
//            }
        }
        self.isLoading = false
    }
}
