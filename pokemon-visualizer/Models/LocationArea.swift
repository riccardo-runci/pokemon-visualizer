//
//  LocationArea.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 28/10/21.
//

import Foundation

// MARK: - PokemonForm
struct LocationArea: Codable {
    let locationArea: UrlElement?

    enum CodingKeys: String, CodingKey {
        case locationArea = "location_area"
    }
}
