//
//  ContentView.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI
import OMModels
import OMNetworking

struct HomeView: View {

    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State private var searchTerm = ""
    var pokemons: [NamedItem] {
        if !searchTerm.isEmpty {
            viewModel.pokemons.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
        } else {
            viewModel.pokemons
        }
    }

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                LoadingView()
            case .error(let error):
                VStack {
                    Text(String(localized: "generic_error_title"))
                    Text(error)
                }
            case .idle:
                List {
                    ForEach(pokemons, id: \.id) { pokemon in
                        NavigationLink {
                            PokemonDetailView(pokemon: pokemon)
                        } label: {
                            Text(pokemon.name.capitalized)
                        }
                    }
                }
                .searchable(text: $searchTerm, prompt: String(localized: "whos_that_pokemon"))
            }
        }
        .navigationTitle(title)
        .onAppear(perform: {
            searchTerm = ""
            Task {
                await viewModel.loadPokemon()
            }
        })
    }
}

extension HomeView {
    var title: String {
        String(localized: "pokedex")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
