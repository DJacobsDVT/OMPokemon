//
//  PokemonItem.swift
//  OMModels
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import Foundation

struct PokemonItem: Codable, Sendable, Identifiable {
    public let id: Int
    public let name: String
    public let sprites: Sprites
    public let stats: [Stat]
    public let types: [TypeElement]
    public let weight: Int
    public let abilities: [Ability]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sprites
        case stats
        case types
        case weight
        case abilities
    }
}

// MARK: - Ability
struct Ability: Codable, Sendable {
    let ability: NamedItem
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}


// MARK: - Sprites
struct Sprites: Codable, Sendable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}


// MARK: - Stat
struct Stat: Codable, Sendable {
    let baseStat, effort: Int
    let stat: NamedItem

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement: Codable, Sendable {
    let slot: Int
    let type: NamedItem
}
