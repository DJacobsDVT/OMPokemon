//
//  PokemonView.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI
import OMModels

struct PokemonDetailView: View {

    let pokemon: NamedItem

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    PokemonDetailView(pokemon: NamedItem(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25"))
}

