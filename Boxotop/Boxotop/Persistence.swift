//
//  Persistence.swift
//  Boxotop
//
//  Created by Manon Russo  on 24/05/2024.
//

import CoreData

struct PersistenceController {
    // MARK: - Properties
    static let shared = PersistenceController()
    var error: Error?
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Boxotop")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Core data error:", error)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension Item {
    func toMovie() -> Movie {
        return Movie(
            title: self.title ?? "N/A",
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
            imdbVotes: nil,
            imdbID: nil,
            type: "N/A",
            dvd: nil,
            boxOffice: nil,
            production: nil,
            website: nil,
            response: nil
        )
    }
}
