//
//  PokemonService.swift
//  OMNetworking
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import Foundation
import OMModels

public protocol PokemonService {
    func fetchPokemonList(limit: Int) async throws -> [NamedItem]?
    func fetchPokemon(named name: String) async throws -> PokemonItem?
}

extension PokemonService {
    public func fetchPokemonList(limit: Int = 100) async throws -> [NamedItem]? {
        try await fetchPokemonList(limit: limit)
    }
}
