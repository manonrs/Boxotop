//
//  FavListView.swift
//  Boxotop
//
//  Created by Manon Russo  on 28/05/2024.
//

import SwiftUI

struct FavListView: View {
    
    let persistenceController = PersistenceController.shared
    @FetchRequest(sortDescriptors: [])
    var favMovies: FetchedResults<Item>

    var body: some View {
        NavigationStack {
            List {
                ForEach(favMovies) { item in
                    if let title = item.title {
                        NavigationLink(destination: MovieDetailsView(movie: item.toMovie())) { // Assurez-vous d'avoir une méthode pour convertir Item en Movie
                            Text(title)
                        }
                    } else {
                        Text("No title")
                    }
                }
            }
        }
        .navigationTitle("My favourites")
    }
}

extension Item {
    func toMovie() -> Movie {
        return Movie(title: self.title ?? "N/A",
                     year: self.year ?? "N/A",
                     rated: nil,
                     released: nil,
                     runtime: nil,
                     genre: self.genre,
                     director: self.director,
                     writer: self.writer,
                     actors: self.actors, 
                     plot: self.plot ?? "N/A",
                     language: nil,
                     country: nil,
                     awards: nil,
                     poster: self.poster, 
                     ratings: nil,
                     metascore: nil,
                     imdbRating: nil,
                     imdbVotes: nil, imdbID: nil,
                     type: "N/A",
                     dvd: nil,
                     boxOffice: nil,
                     production: nil,
                     website: nil,
                     response: nil
        )
    }
}
