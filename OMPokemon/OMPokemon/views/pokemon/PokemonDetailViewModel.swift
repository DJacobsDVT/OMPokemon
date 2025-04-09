//
//  PokemonViewViewModel.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI
import OMNetworking
import OMModels
import Factory
import OSLog

final class PokemonDetailViewModel: BaseObservable {
    @MainActor @Published var state: ViewState = .idle
    private var pokemonDetail: PokemonItem?
    var pokemonDTO: PokemonDetailDTO? {
        guard let pokemonDetail else { return nil }
        return createPokemonDTO(from: pokemonDetail)
    }

    @Injected(\.pokemonService) private var pokemonService: PokemonService
    private let pokemon: NamedItem

    init(pokemon: NamedItem) {
        self.pokemon = pokemon
    }

    @MainActor
    func loadPokemonDetail() async {
        state = .loading
        do {
            guard let result = try await pokemonService.fetchPokemon(named: pokemon.name) else {
                state = ViewState.error("something_went_wrong")
                return
            }
            self.pokemonDetail = result
            state = .loaded
        } catch {
            Logger.app.error("Failed to load pokemon detail: \(error)")
            state = ViewState.error("something_went_wrong")
        }
    }

    private func createPokemonDTO(from response: PokemonItem) -> PokemonDetailDTO {
        var sections: [String: [ListItem]] = [:]
        sections["type"] = [ListItem(label: response.types.map { $0.type.name.capitalized }.joined(separator: ", "))]
        sections["statistics"] = response.stats.map { stat in
            ListItem(label: stat.stat.name.userFriendlyName, value: "\(stat.baseStat)")
        }
        sections["measurements"] = [ListItem(label: String(localized: "weight_title"), value: "\(response.weight / 10) kg"),
                                    ListItem(label: String(localized: "height_title"), value: "\(response.height * 10) cm")]

        return PokemonDetailDTO(name: response.name.capitalized,
                                spriteURL: URL(string: response.sprites.frontDefault),
                                sections: sections)
    }
}
