//
//  HomeViewModelTests.swift
//  OMPokemon
//

import Testing
import OMModels
import Foundation
import OMNetworking
@testable import OMPokemon

@Suite("Home ViewModel Tests")
class HomeViewModelTests {

    @Test func testThatFetchPokemonListSucceeds() async throws {
        // Arrange
        let mockService = MockPokemonService()
        let pokemonItems: PokemonListResponse? = MockDataHelper.readJson(from: "pokemon_list", for: PokemonListResponse.self)

        mockService.fetchPokemonListResult = pokemonItems?.results

        let systemUnderTest = HomeViewModel(pokemonService: mockService)

        // Act
        await systemUnderTest.loadPokemon()

        // Assert
        #expect(await systemUnderTest.state == ViewState.idle)
        #expect(await !systemUnderTest.pokemons.isEmpty)
        #expect(mockService.fetchPokemonListCalled)
    }

    @Test func testThatFetchPokemonListFails() async throws {
        // Arrange
        let mockService = MockPokemonService()
        mockService.errorToThrowWhenFetchPokemonList = NetworkError.badRequest

        let systemUnderTest = HomeViewModel(pokemonService: mockService)

        // Act
        await systemUnderTest.loadPokemon()

        // Assert
        #expect(await systemUnderTest.pokemons.isEmpty)
        #expect(await systemUnderTest.state == ViewState.error(String(localized: "something_went_wrong")))
        #expect(mockService.fetchPokemonListCalled)
    }

    @Test func testThatFetchPokemonListFailsOnNilResponse() async throws {
        // Arrange
        let mockService = MockPokemonService()
        mockService.fetchPokemonListResult = nil

        let systemUnderTest = HomeViewModel(pokemonService: mockService)

        // Act
        await systemUnderTest.loadPokemon()

        // Assert
        #expect(await systemUnderTest.pokemons.isEmpty)
        #expect(await systemUnderTest.state == ViewState.error(String(localized: "something_went_wrong")))
        #expect(mockService.fetchPokemonListCalled)
    }
}

