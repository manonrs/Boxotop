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
    let persistenceController = PersistenceController.shared

    var body: some View {
        NavigationStack(path: $navigationPath) {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.searchResult) { movie in
                        NavigationLink(value: movie) {
                            Section {
                                HStack {
                                    MoviePosterView(poster: movie.poster)
                                        .padding()
                                    
                                    VStack(alignment: .leading) {
                                        Text(movie.title)
                                            .bold()
                                        Text("\(movie.type) - \(movie.year)")
                                    }
                                }
                            }
                            .frame(height: 170)
                        }
                    }
                }
                .background(.red.opacity(0.2))
                .navigationTitle("🍿 Boxotop")
                .listRowInsets(EdgeInsets())
                .listStyle(.insetGrouped)
                .navigationDestination(for: Movie.self) { movie in
                    MovieDetailsView(movie: movie)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)

                }
                .overlay {
                    if viewModel.searchResult.isEmpty && !viewModel.searchQuery.isEmpty {
                        ContentUnavailableView.search
                    }
                }
                .searchable(text: $viewModel.searchQuery)
            }
        }
        .errorAlert(error: $viewModel.error)
        .task {
            await viewModel.fetchMovies()
        }
    }
}

#Preview {
    MovieListView()
}
