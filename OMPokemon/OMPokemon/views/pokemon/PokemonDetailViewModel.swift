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
    @Published var state: ViewState = .idle
    private var pokemonDetail: PokemonItem?
    private(set) var pokemonDTO: PokemonDetailDTO?

    @Injected(\.pokemonService) private var pokemonService: PokemonService
    private let pokemon: NamedItem

    init(pokemon: NamedItem) {
        self.pokemon = pokemon
    }

    func loadPokemonDetail() async {
        state = .loading
        do {
            guard let result = try await pokemonService.fetchPokemon(named: pokemon.name) else {
                state = ViewState.error(String(localized: "something_went_wrong"))
                return
            }
            self.pokemonDetail = result
            self.pokemonDTO = createPokemonDTO(from: result)
            state = .idle
        } catch {
            Logger.app.error("Failed to load pokemon detail: \(error)")
            state = ViewState.error(String(localized: "something_went_wrong"))
        }
    }

    private func createPokemonDTO(from response: PokemonItem) -> PokemonDetailDTO {
        var sections: [String: [ListItem]] = [:]
        sections[String(localized: "type")] = [ListItem(label: response.types.first?.type.name.capitalized ?? "")]
        sections[String(localized: "statistics")] = response.stats.map { stat in
            ListItem(label: stat.stat.name.userFriendlyName, value: "\(stat.baseStat)")
        }
        sections[String(localized: "measurements")] = [ListItem(label: String(localized: "weight"), value: "\(response.weight / 10) kg"),
                                                       ListItem(label: String(localized: "height"), value: "\(response.height * 10) cm")]

        return PokemonDetailDTO(name: response.name.capitalized,
                                spriteURL: URL(string: response.sprites.frontDefault),
                                sections: sections)
    }
}
