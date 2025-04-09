//
//  PokemonView.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI
import OMModels
import Factory

struct PokemonDetailView: View {

    @StateObject var viewModel: PokemonDetailViewModel

    init(pokemon: NamedItem) {
        self._viewModel = StateObject(wrappedValue: PokemonDetailViewModel(pokemon: pokemon))
    }

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                LoadingView()
            case .error(let error):
                GenericErrorView(errorMessage: error)
            case .loaded:
                if let dto = viewModel.pokemonDTO {
                    List {
                        PokemonDetailHeaderView(title: dto.name, imageUrl: dto.spriteURL)
                        PokemonDetailBodyView(sections: dto.sections)
                    }
                } else {
                    GenericErrorView(errorMessage: "something_went_wrong")
                }
            default:
                EmptyView()
            }
        }
        .onAppear(perform: {
            Task {
                await viewModel.loadPokemonDetail()
            }
        })
    }
}

fileprivate struct PokemonDetailHeaderView: View {

    let title: String
    let imageUrl: URL?

    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                Text(title)
                    .font(.system(.largeTitle, design: .default, weight: .bold))
            }
            Spacer()
        }
    }
}

fileprivate struct PokemonDetailBodyView: View {

    let sections: [String: [ListItem]]

    var body: some View {
        ForEach(Array(sections.keys).sorted(by: >), id: \.self) { (section: String) in
            Section(header: Text(section)) {
                PokemonDetailRowItems(items: sections[section] ?? [])
            }
        }
    }
}

fileprivate struct PokemonDetailRowItems: View {

    let items: [ListItem]

    var body: some View {
        ForEach(items) { (listItem: ListItem) in
            HStack {
                Text(listItem.label)
                Spacer()
                Text(listItem.value ?? "")
                    .foregroundStyle(.accent)
                    .opacity(listItem.value == nil ? 0 : 1)
            }
        }
    }
}

#Preview {
    let _ = Container.shared.pokemonService.register { PreviewPokemonService() }
    NavigationStack {
        PokemonDetailView(pokemon: NamedItem(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25"))
    }
}

