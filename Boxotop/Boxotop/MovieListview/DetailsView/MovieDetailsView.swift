//
//  MovieDetailsView.swift
//  Boxotop
//
//  Created by Manon Russo  on 26/05/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    
    //MARK: - Properties
    @State var isShowingFullScreen = false
    @State private var viewModel = MovieDetailsViewViewModel()
    @FetchRequest(sortDescriptors: [])
    var favMovies: FetchedResults<Item>

    let movie: Movie
    let persistenceController = PersistenceController.shared

    var body: some View {
        VStack {
            HStack(spacing: 8) {
                MoviePosterView(poster: movie.poster)
                    .frame(width: 100, height: 120)
                    .onTapGesture {
                        isShowingFullScreen = true
                    }
                    .sheet(isPresented: $isShowingFullScreen) {
                        MoviePosterView(poster: movie.poster)
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    }
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title)
                }
            }
            .padding()
            List {
                Section {
                    VStack(alignment: .leading) {
                        Text("👥 Plot\n")
                        Text(((movie.plot == "N/A") ? "No plot available yet for this movie, sorry " : movie.plot ))
                    }
                    NavigationLink(destination: WebView(url: URL(string: "https://www.google.fr/search?q=\(movie.title)")!)) {
                        Text("👀 Find more movie info")
                    }
                }
                if let actors = movie.actors {
                    LabeledContent("👥 Main cast", value: actors)
                }
                if let director = movie.director {
                    LabeledContent("🎥 Director", value: director)
                }
                if let writer = movie.writer {
                    LabeledContent("✍️ Writer", value: writer)
                }
                if let ratings = movie.ratings,
                   ratings != [] {
                    Section("★ What viewers say about it") {
                        ForEach(ratings, id: \.id) { rating in
                            let note = rating.value
                            let source = rating.source
                            
                            VStack(alignment: .leading) {
                                Text("\(source.rawValue) \(note)")
                                HStack {
                                    switch source {
                                    case .internetMovieDatabase:
                                        ProgressView(value: viewModel.convertIMDBRatingToProgress(rating: note))
                                            .padding(.bottom)
                                        
                                    case .metacritic:
                                        ProgressView(value: viewModel.convertMetacriticRatingToProgress(rating: note))
                                            .padding(.bottom)
                                        
                                    case .rottenTomatoes:
                                        ProgressView(value: viewModel.convertRottenRatting(percentage: note))
                                            .padding(.bottom)
                                        
                                    case .unknown:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                    }
                }
                Section {
                    NavigationLink(destination: WebView(url: URL(string: "https://www.google.fr/search?q=\(movie.title)+seance+aujourd'hui")!)) {
                        Text("📍 Find a screening")
                    }
                }
            }
        }
        .task {
            isMovieFavourite()
        }
        .errorAlert(error: $viewModel.error)
        .navigationBarItems(trailing:
                                Button {
            viewModel.isFavourite ? removeItem() : addItem()
        } label: {
            Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
        }
        )
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Private Core Data methods
    private func isMovieFavourite() {
        viewModel.isLoading = true
        for favMovie in favMovies where favMovie.title == movie.title {
            viewModel.isFavourite = true
        }
        viewModel.isLoading = false
    }

    private func removeItem() {
        withAnimation {
            for favMovie in favMovies where favMovie.title == movie.title {
                persistenceController.container.viewContext.delete(favMovie)
            }
            do {
                try persistenceController.container.viewContext.save()
                viewModel.isFavourite = false
            } catch {
                viewModel.error = error
            }
        }
    }

    private func addItem() {
        let newItem = Item(context: persistenceController.container.viewContext)
        newItem.title = movie.title
        newItem.id = movie.id
        newItem.actors = movie.actors
        newItem.director = movie.director
        newItem.genre = movie.genre
        newItem.plot = movie.plot
        newItem.poster = movie.poster
        newItem.writer = movie.writer
        newItem.year = movie.year
        do {
            try persistenceController.container.viewContext.save()
            viewModel.isFavourite = true
        } catch {
            viewModel.error = error
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailsView(movie: .example)
    }
}
