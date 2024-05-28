//
//  MoviePosterView.swift
//  Boxotop
//
//  Created by Manon Russo  on 26/05/2024.
//

import SwiftUI

struct MoviePosterView: View {
    
    let poster: String?
    
    var body: some View {
        if poster != "N/A",
           let poster = poster {
            AsyncImage(url: URL(string: poster)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 100)
        } else {
            Image(systemName: "square.slash")
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 150)
                .background(.gray)
        }
    }
}

#Preview {
    MoviePosterView(poster: "N/A")
}
