//
//  MovieDetailsView.swift
//  Boxotop
//
//  Created by Manon Russo  on 26/05/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let movie: MovieRemote
    @State var rottenTomatoesRating: Double = 0.0
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                MoviePosterView(poster: movie.poster)
                    .frame(width: 100, height: 120)
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title)
                }
                
            }
            .padding()
        }
        VStack(alignment: .leading, spacing: 16) {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Text("👥 Plot\n")
                        Text(((movie.plot == "N/A") ? "No plot available yet  for this movie, sorry " : movie.plot ))
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
                if let ratings = movie.ratings {
                    ForEach(ratings, id: \.id) { rating in
                        let note = rating.value
                        let source = rating.source
                        
                        VStack(alignment: .leading) {
                            Text("\(source.rawValue) \(note)")
                            HStack {
                                switch source {
                                case .internetMovieDatabase:
                                    ProgressView(value: convertIMDBRatingToProgress(rating: note))
                                        .padding(.bottom)
                                    
                                case .metacritic:
                                    ProgressView(value: convertMetacriticRatingToProgress(rating: note))
                                        .padding(.bottom)
                                
                                case .rottenTomatoes:
                                    ProgressView(value: convertRottenRatting())
                                        .padding(.bottom)
                                        
                                default:
                                    EmptyView()
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
    }
    
    private func convertRottenRatting() -> Double{
        if let ratingString = movie.ratings?.first?.value {
            let cleanedString = ratingString.replacingOccurrences(of: "%", with: "")
            if let progressValue = Double(cleanedString) {
                rottenTomatoesRating = progressValue / 100
            }
        }
        return rottenTomatoesRating
    }
    
    private func convertIMDBRatingToProgress(rating: String) -> Double {
        let components = rating.split(separator: "/")
        if let score = components.first, let scoreDouble = Double(score) {
            return scoreDouble / 10.0
        }
        return 0.0
    }

    private func convertMetacriticRatingToProgress(rating: String) -> Double {
        let components = rating.split(separator: "/")
        if let score = components.first, let scoreDouble = Double(score) {
            return scoreDouble / 100.0
        }
        return 0.0
    }
}
#Preview {
    NavigationStack {
        MovieDetailsView(movie: .example, rottenTomatoesRating: 0.75)
    }
}