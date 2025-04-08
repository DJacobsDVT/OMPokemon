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
    public let height: Double
    public let abilities: [Ability]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sprites
        case stats
        case types
        case weight
        case height
        case abilities
    }

    public static func == (lhs: PokemonItem, rhs: PokemonItem) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Ability
public struct Ability: Codable, Sendable {
    public let ability: NamedItem
    public let isHidden: Bool
    public let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Sprites
public struct Sprites: Codable, Sendable {
    public let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}


// MARK: - Stat
public struct Stat: Codable, Sendable {
    public let baseStat, effort: Int
    public let stat: StatDetail

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

public enum StatName: String, Codable, Sendable {
    case hp = "hp"
    case attack = "attack"
    case defense = "defense"
    case specialAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed = "speed"

    public var userFriendlyName: String {
        switch self {
        case .hp:
            "Health Points"
        case .attack:
            "Attack"
        case .defense:
            "Defense"
        case .specialAttack:
            "Special Attack"
        case .specialDefense:
            "Special Defense"
        case .speed:
            "Speed"
        default:
            "Unknown"
        }
    }
}

public struct StatDetail: Codable, Sendable {
    public let name: StatName
    public let url: String
}

// MARK: - TypeElement
public struct TypeElement: Codable, Sendable {
    public let slot: Int
    public let type: NamedItem
}
