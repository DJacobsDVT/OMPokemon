//
//  PokemonListItem.swift
//  OMModels
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import Foundation

struct NamedItem: Codable, Sendable, Identifiable {
    public let id: String = UUID().uuidString
    public let name: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case url = "url"
    }
}
