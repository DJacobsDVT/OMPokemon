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

public final class PokemonServiceImpl: PokemonService {

    @Injected(\.baseService) private var baseService: BaseService

    public init() {}

    public func fetchPokemon(named name: String) async throws -> PokemonItem? {
        let path = "pokemon/\(name.trimmingCharacters(in: .whitespacesAndNewlines))"
        return try await baseService.get(path: path, type: PokemonItem.self)
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
