//
//  HomeViewModel.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI
import OMNetworking
import OMModels

public final class HomeViewModel: BaseObservable {
    @MainActor @Published var state: ViewState = .idle
    @MainActor @Published var pokemons: [NamedItem] = []

    private let pokemonService: PokemonService

    init(pokemonService: PokemonService = PokemonServiceImpl()) {
        self.pokemonService = pokemonService
    }

    @MainActor
    func loadPokemon() async {
        state = .loading
        do {
            self.pokemons = try await pokemonService.fetchPokemonList(limit: 100)
            state = .idle
        } catch {
            state = ViewState.error(String(localized: "something_went_wrong"))
        }
    }
}
