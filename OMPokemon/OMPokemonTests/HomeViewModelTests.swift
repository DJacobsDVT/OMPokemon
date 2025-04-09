//
//  HomeViewModelTests.swift
//  OMPokemon
//

import Testing
import OMModels
import Foundation
import OMNetworking
import Factory
@testable import OMPokemon

@Suite("Home ViewModel Tests", .serialized)
class HomeViewModelTests {

    @Test func testThatFetchPokemonListSucceeds() async throws {
        // Arrange
        let mockService = MockPokemonService()
        let pokemonItems: PokemonListResponse? = MockDataHelper.readJson(from: "pokemon_list", for: PokemonListResponse.self)

        mockService.fetchPokemonListResult = pokemonItems?.results
        Container.shared.pokemonService.register { mockService }

        let systemUnderTest = HomeViewModel()

        // Act
        await systemUnderTest.loadPokemon()

        // Assert
        #expect(await systemUnderTest.state == ViewState.loaded)
        #expect(await !systemUnderTest.pokemons.isEmpty)
        #expect(mockService.fetchPokemonListCalled)
    }

    @Test func testThatFetchPokemonListFails() async throws {
        // Arrange
        let mockService = MockPokemonService()
        mockService.errorToThrowWhenFetchPokemonList = NetworkError.badRequest
        Container.shared.pokemonService.register { mockService }

        let systemUnderTest = HomeViewModel()

        // Act
        await systemUnderTest.loadPokemon()

        // Assert
        #expect(await systemUnderTest.pokemons.isEmpty)
        #expect(await systemUnderTest.state == ViewState.error("something_went_wrong"))
        #expect(mockService.fetchPokemonListCalled)
    }

    @Test func testThatFetchPokemonListFailsOnNilResponse() async throws {
        // Arrange
        let mockService = MockPokemonService()
        mockService.fetchPokemonListResult = nil
        Container.shared.pokemonService.register { mockService }

        let systemUnderTest = HomeViewModel()

        // Act
        await systemUnderTest.loadPokemon()

        // Assert
        #expect(await systemUnderTest.pokemons.isEmpty)
        #expect(await systemUnderTest.state == ViewState.error("something_went_wrong"))
        #expect(mockService.fetchPokemonListCalled)
    }

    deinit {
        Container.shared.reset()
    }
}

