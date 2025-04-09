//
//  ViewState.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

enum ViewState: Equatable, Sendable {
    case loading
    case error(String)
    case idle
}

