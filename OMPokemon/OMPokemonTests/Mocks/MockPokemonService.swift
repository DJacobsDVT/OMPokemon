//
//  MockPokemonService.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import Foundation
import OMModels
import OMNetworking

class MockPokemonService: PokemonService {

    var fetchPokemonListCallsCount = 0
    var fetchPokemonListCalled: Bool {
        return fetchPokemonListCallsCount > 0
    }
    var fetchPokemonListResult: [NamedItem]?
    var errorToThrowWhenFetchPokemonList: Error?
    func fetchPokemonList(limit: Int) async throws -> [NamedItem]? {
        fetchPokemonListCallsCount += 1
        if let errorToThrowWhenFetchPokemonList {
            throw errorToThrowWhenFetchPokemonList
        } else {
            return fetchPokemonListResult
        }
    }

    var fetchPokemonCallsCount = 0
    var fetchPokemonCalled: Bool {
        return fetchPokemonCallsCount > 0
    }
    var fetchPokemonResult: PokemonItem?
    var errorToThrowWhenFetchPokemon: Error?
    func fetchPokemon(named name: String) async throws -> PokemonItem? {
        fetchPokemonCallsCount += 1
        if let errorToThrowWhenFetchPokemon {
            throw errorToThrowWhenFetchPokemon
        } else {
            return fetchPokemonResult
        }
    }
}

