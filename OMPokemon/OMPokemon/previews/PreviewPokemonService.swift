//
//  PreviewPokemonService.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import OMModels
import OMNetworking

struct PreviewPokemonService: PokemonService {

    func fetchPokemonList(limit: Int) async throws -> [NamedItem]? {
        // Ignoring limit variable as this is for preview use.
        let data = MockDataHelper.readJson(from: "pokemon_list", for: [NamedItem].self)
        return data
    }

    func fetchPokemon(named name: String) async throws -> PokemonItem? {
        let data = MockDataHelper.readJson(from: "pokemon", for: PokemonItem.self)
        return data
    }
}
