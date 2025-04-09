//
//  ContentView.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI
import OMModels
import OMNetworking
import Factory

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    @State private var searchTerm = ""
    var pokemons: [NamedItem] {
        if searchTerm.isEmpty {
            viewModel.pokemons
        } else {
            viewModel.pokemons.filter { $0.name.caseInsenstiveContains(searchTerm) }
        }
    }

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                LoadingView()
            case .error(let error):
                GenericErrorView(errorMessage: error)
            case .loaded:
                List {
                    ForEach(pokemons, id: \.id) { pokemon in
                        NavigationLink {
                            PokemonDetailView(pokemon: pokemon)
                        } label: {
                            HStack {
                                Image("pokeball")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                Text(pokemon.name.capitalized)
                            }
                        }.onAppear {
                            Task {

                            }
                        }
                    }
                }
                .searchable(text: $searchTerm, prompt: "whos_that_pokemon")
            default:
                EmptyView()
            }
        }
        .navigationTitle("pokedex")
        .onAppear(perform: {
            searchTerm = ""
            Task {
                await viewModel.loadPokemon()
            }
        })
    }
}

#Preview {
    let _ = Container.shared.pokemonService.register { PreviewPokemonService() }
    NavigationStack {
        HomeView()
    }
}
