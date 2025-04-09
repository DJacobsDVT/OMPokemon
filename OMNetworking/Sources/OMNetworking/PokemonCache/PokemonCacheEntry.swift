//
//  PokemonCacheEntry.swift
//  OMNetworking
//
//  Created by Daniel Jacobs on 2025/04/09.
//

import OMModels

final class PokemonCacheEntryObject {
    let entry: PokemonCacheEntry
    init(entry: PokemonCacheEntry) { self.entry = entry }
}

enum PokemonCacheEntry {
    case inProgress(Task<PokemonItem?, Error>)
    case ready(PokemonItem?)
}
