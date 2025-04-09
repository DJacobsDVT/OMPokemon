//
//  PokemonSerivceImpl.swift
//  OMNetworking
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import Foundation
import OMModels
import Factory
import OSLog

public final actor PokemonServiceImpl: PokemonService {

    @Injected(\.baseService) private var baseService: BaseService
    private let pokemonCache: NSCache<NSString, PokemonCacheEntryObject> = NSCache()

    public init() {}

    public func fetchPokemon(named name: String) async throws -> PokemonItem? {
        if let cached = pokemonCache[name] {
            switch cached {
            case .ready(let pokemonItem):
                return pokemonItem
            case .inProgress(let task):
                return try await task.value
            }
        }

        let task = Task<PokemonItem?, Error> {
            let path = "pokemon/\(name.trimmingCharacters(in: .whitespacesAndNewlines))"
            return try await baseService.get(path: path, type: PokemonItem.self)
        }
        pokemonCache[name] = .inProgress(task)
        do {
            let item = try await task.value
            pokemonCache[name] = .ready(item)
            return item
        } catch {
            pokemonCache[name] = nil
            throw error
        }
    }

    public func fetchPokemonList(limit: Int) async throws -> [NamedItem]? {
        var components = URLComponents()
        components.path = "pokemon"
        components.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)")
        ]

        guard let urlPathWithQuery = components.url?.relativeString else {
            Logger.network.warning("Unable to formulate URL to retrieve Pokemon List")
            throw NetworkError.badURL
        }
        
        let result: PokemonListResponse = try await baseService.get(path: urlPathWithQuery, type: PokemonListResponse.self)

        return result.results
    }
}
