//
//  PokemonListResponse.swift
//  OMModels
//

public struct PokemonListResponse: Codable {
    public let count: Int
    public let next: String
    public let results: [NamedItem]
}
