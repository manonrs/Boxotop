//
//  MovieDetailsViewViewModel.swift
//  Boxotop
//
//  Created by Manon Russo  on 28/05/2024.
//

import Foundation
import Observation

@Observable
final class MovieDetailsViewViewModel {
    var isFavourite = false
    var isLoading = false
    var error: Error?

    func convertRottenRatting(percentage: String) -> Double {
        let cleanedString = percentage.replacingOccurrences(of: "%", with: "")
        if let percentageValue = Double(cleanedString) {
            return percentageValue / 100.0
        }
        return 0.0
    }
    
    func convertIMDBRatingToProgress(rating: String) -> Double {
        let components = rating.split(separator: "/")
        if let score = components.first, let scoreDouble = Double(score) {
            return scoreDouble / 10.0
        }
        return 0.0
    }

    func convertMetacriticRatingToProgress(rating: String) -> Double {
        let components = rating.split(separator: "/")
        if let score = components.first, let scoreDouble = Double(score) {
            return scoreDouble / 100.0
        }
        return 0.0
    }
}

