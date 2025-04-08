//
//  PokemonDetailDTO.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import Foundation

struct PokemonDetailDTO: Sendable {
    let name: String
    let spriteURL: URL?
    let sections: [String: [ListItem]]
}

struct ListItem: Identifiable {
    let id: String = UUID().uuidString
    let label: String
    let value: String?

    init(label: String, value: String? = nil) {
        self.label = label
        self.value = value
    }
}
