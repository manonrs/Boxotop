//
//  MovieDetailsView.swift
//  Boxotop
//
//  Created by Manon Russo  on 26/05/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: MovieRemote
    
    var body: some View {
        HStack {
            VStack {
                Text(movie.title)
                if let plot = movie.plot {
                    Text(plot)
                }
            }
            MoviePosterView(poster: movie.poster)

        }
    }
}
//#Preview {
//    MovieDetailsView(movie:
//            .init(
//        title: "Fake movie",
//        year: "2024",
//        imdbID: "xxxx",
//        type: "movie",
//        poster: "https://www.google.fr",
//        genre: "Action",
//        releaseDate: "01/01/2024",
//        rated: "6/10",
//        actors: "John Doe",
//        plot: "Discover the movie plot"))
//}
