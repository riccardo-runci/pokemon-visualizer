//
//  Pokemon.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import Foundation

// MARK: - Pokemon
struct PokemonDetail: Codable {
    let abilities: [Ability]?
    let baseExperience: Int?
    let forms: [UrlElement]?
    let gameIndices: [GameIndex]?
    let height: Int?
    let id: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [Move]?
    let name: String?
    let order: Int?
    let species: UrlElement?
    let stats: [Stat]?
    let weight: Int?
    var pokemonForms: PokemonForms?
    var pokemonAbilities: [PokemonAbility] = []
    
    var imageUrl: String? {
        guard let pokemonId = self.id else { return nil }
        return APIService.shared.baseImageUrl + "/\(pokemonId).png"
    }

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case gameIndices = "game_indices"
        case height
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves, name, order
        case species, stats, weight
    }
}

// MARK: - Ability
struct Ability: Codable {
    let ability: UrlElement?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Move
struct Move: Codable {
    let move: UrlElement?

    enum CodingKeys: String, CodingKey {
        case move
    }
}


// MARK: - GameIndex
struct GameIndex: Codable {
    let gameIndex: Int?
    let version: UrlElement?

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int?
    let stat: UrlElement?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}


