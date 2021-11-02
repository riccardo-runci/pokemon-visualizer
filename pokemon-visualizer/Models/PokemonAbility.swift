//
//  PokemonAbility.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 28/10/21.
//

import Foundation

// MARK: - PokemonAbility
struct PokemonAbility: Codable {
    let effectEntries: [EffectEntry]?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case name
    }
}

// MARK: - EffectEntry
struct EffectEntry: Codable {
    let effect: String?
    let language: UrlElement?
    let shortEffect: String?

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}
