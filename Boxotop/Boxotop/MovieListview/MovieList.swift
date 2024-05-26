//
//  MovieList.swift
//  Boxotop
//
//  Created by Manon Russo  on 24/05/2024.
//

import SwiftUI

struct MovieListView: View {
    @State private var navigationPath = NavigationPath()
    @State private var viewModel = MoviesListViewModel()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                ForEach(viewModel.searchResult) { movie in
                    NavigationLink(value: movie) {
                        Section {
                            HStack {
                                MoviePosterView(poster: movie.poster)
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                        .bold()
                                    Text("\(movie.type) - \(movie.year)")
                                }
                            }
                        }
                        .frame(height: 130)
                    }
                }
            }
            .navigationDestination(for: MovieRemote.self) { movie in
                MovieDetailsView(movie: movie)
            }

            .navigationTitle("🍿 Boxotop")
            .searchable(text: $viewModel.searchQuery)
            .task {
                await viewModel.fetchMovies()
            }
        }

    }
}

#Preview {
    MovieListView()
}
