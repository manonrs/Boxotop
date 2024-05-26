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
            // mettre image placeholder si NA
            AsyncImage(url: URL(string: poster)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 80, height: 80)
        } else {
            Image(systemName: "square.slash")
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
            
        }
    }
}

//#Preview {
//    MoviePosterView()
//}
