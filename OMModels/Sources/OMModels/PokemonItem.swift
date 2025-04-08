//
//  PokemonItem.swift
//  OMModels
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import Foundation

public struct PokemonItem: Codable, Sendable, Identifiable, Equatable {

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

    public static func == (lhs: PokemonItem, rhs: PokemonItem) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Ability
public struct Ability: Codable, Sendable {
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
public struct Sprites: Codable, Sendable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}


// MARK: - Stat
public struct Stat: Codable, Sendable {
    let baseStat, effort: Int
    let stat: NamedItem

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
public struct TypeElement: Codable, Sendable {
    let slot: Int
    let type: NamedItem
}
