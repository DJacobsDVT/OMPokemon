//
//  HomeViewModel.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI
import OMNetworking
import OMModels
import Factory
import OSLog

final class HomeViewModel: BaseObservable {
    @Published var state: ViewState = .idle
    @Published var pokemons: [NamedItem] = []

    @Injected(\.pokemonService) private var pokemonService: PokemonService

    func loadPokemon() async {
        state = .loading
        do {
            guard let result = try await pokemonService.fetchPokemonList(limit: 100) else {
                state = ViewState.error(String(localized: "something_went_wrong"))
                return
            }
            self.pokemons = result
            state = .idle
        } catch {
            Logger.app.error("Failed to load pokemon detail: \(error)")
            state = ViewState.error(String(localized: "something_went_wrong"))
        }
    }
}
