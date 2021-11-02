//
//  PokemonList.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import Foundation

// MARK: - PokemonList
struct PokemonList: Codable {
    let count: Int?
    var results: [PokemonListResult]
}

// MARK: - Result
struct PokemonListResult: Codable {
    let name: String?
    let url: String?
    
    var imageUrl: String? {
        guard let pokemonId = URL(string: self.url ?? "")?.lastPathComponent else { return nil }
        return APIService.shared.baseImageUrl + "/\(pokemonId).png"
    }
}
