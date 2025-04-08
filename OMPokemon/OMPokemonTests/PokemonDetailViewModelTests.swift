//
//  PokemonDetailViewModelTests.swift
//  OMPokemon
//

import Testing
import OMModels
import Foundation
import OMNetworking
@testable import OMPokemon

@Suite("Pokemon Detail ViewModel Tests")
class PokemonDetailViewModelTests {

    @Test func testThatFetchPokemonSucceeds() async throws {
        // Arrange
        let mockService = MockPokemonService()
        let pokemonItem: PokemonItem? = MockDataHelper.readJson(from: "pokemon", for: PokemonItem.self)
        mockService.fetchPokemonResult = pokemonItem

        let systemUnderTest = PokemonDetailViewModel(pokemon: NamedItem(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25"),
                                                     pokemonService: mockService)

        // Act
        await systemUnderTest.loadPokemonDetail()

        // Assert
        #expect(systemUnderTest.pokemonDTO != nil)
        #expect(systemUnderTest.pokemonDTO?.name == "Pikachu")
        #expect(await systemUnderTest.state == ViewState.idle)
        #expect(mockService.fetchPokemonCalled)
    }

    @Test func testThatFetchPokemonFails() async throws {
        // Arrange
        let mockService = MockPokemonService()
        mockService.errorToThrowWhenFetchPokemon = NetworkError.badRequest

        let systemUnderTest = PokemonDetailViewModel(pokemon: NamedItem(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25"),
                                                     pokemonService: mockService)

        // Act
        await systemUnderTest.loadPokemonDetail()

        // Assert
        #expect(systemUnderTest.pokemonDTO == nil)
        #expect(await systemUnderTest.state == ViewState.error(String(localized: "something_went_wrong")))
        #expect(mockService.fetchPokemonCalled)
    }

    @Test func testThatFetchPokemonFailsOnNilResponse() async throws {
        // Arrange
        let mockService = MockPokemonService()
        mockService.fetchPokemonResult = nil

        let systemUnderTest = PokemonDetailViewModel(pokemon: NamedItem(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25"),
                                                     pokemonService: mockService)

        // Act
        await systemUnderTest.loadPokemonDetail()

        // Assert
        #expect(systemUnderTest.pokemonDTO == nil)
        #expect(await systemUnderTest.state == ViewState.error(String(localized: "something_went_wrong")))
        #expect(mockService.fetchPokemonCalled)
    }
}

