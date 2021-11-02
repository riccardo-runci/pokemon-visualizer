//
//  PokemonSpecie.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 27/10/21.
//

// MARK: - PokemonForms
struct PokemonForms: Codable {
    let name: String?
    let types: [TypeElement]?

    enum CodingKeys: String, CodingKey {
        case name, types
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int?
    let type: UrlElement?
}

// MARK: - Color
struct UrlElement: Codable {
    let name: String?
    let url: String?
}
