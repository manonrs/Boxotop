//
//  ContentView.swift
//  Boxotop
//
//  Created by Manon Russo  on 24/05/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        Group {
            TabView {
                NavigationStack {
                    MovieListView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
                .tabItem {
                    VStack {
                        Image(systemName: "movieclapper.fill")
                        Text("Screening")
                    }
                }
                NavigationStack {
                    FavListView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
                .tabItem {
                    VStack {
                        Image(systemName: "heart.fill")
                        Text("Fav")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
