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
            if favMovies.isEmpty {
                Text("No favorite movies added yet!")
                    .padding()
            } else {
                List {
                    ForEach(favMovies) { item in
                        if let title = item.title {
                            NavigationLink(destination: MovieDetailsView(movie: item.toMovie())
                                .environment(\.managedObjectContext,
                                              persistenceController.container.viewContext)) {
                                Text(title)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("My favorites")
    }
}
