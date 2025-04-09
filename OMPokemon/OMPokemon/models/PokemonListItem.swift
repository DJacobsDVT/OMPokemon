//
//  PokemonListItem.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/09.
//

import Foundation
import OMModels

class PokemonListItem {
    let name: String
    let informationURL: URL?
    var imageUrl: URL? = nil

    init(namedItem: NamedItem) {
        self.name = namedItem.name
        self.informationURL = URL(string: namedItem.url)
    }

    func updateUrl(_ url: URL) {
        imageUrl = url
    }
}
