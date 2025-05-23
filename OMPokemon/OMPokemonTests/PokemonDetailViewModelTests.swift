//
//  PokemonDetailViewModelTests.swift
//  OMPokemon
//

import Testing
import OMModels
import Foundation
import OMNetworking
import Factory
@testable import OMPokemon

@Suite("Pokemon Detail ViewModel Tests", .serialized)
class PokemonDetailViewModelTests {

    @Test func testThatFetchPokemonSucceeds() async throws {
        // Arrange
        let mockService = MockPokemonService()
        let pokemonItem: PokemonItem? = MockDataHelper.readJson(from: "pokemon", for: PokemonItem.self)
        mockService.fetchPokemonResult = pokemonItem
        Container.shared.pokemonService.register { mockService }

        let systemUnderTest = PokemonDetailViewModel(pokemon: NamedItem(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25"))

        // Act
        await systemUnderTest.loadPokemonDetail()

        // Assert
        #expect(systemUnderTest.pokemonDTO != nil)
        #expect(systemUnderTest.pokemonDTO?.name == "Pikachu")
        #expect(await systemUnderTest.state == ViewState.loaded)
        #expect(mockService.fetchPokemonCalled)
    }

    @Test func testThatFetchPokemonFails() async throws {
        // Arrange
        let mockService = MockPokemonService()
        mockService.errorToThrowWhenFetchPokemon = NetworkError.badRequest
        Container.shared.pokemonService.register { mockService }

        let systemUnderTest = PokemonDetailViewModel(pokemon: NamedItem(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25"))

        // Act
        await systemUnderTest.loadPokemonDetail()

        // Assert
        #expect(systemUnderTest.pokemonDTO == nil)
        #expect(await systemUnderTest.state == ViewState.error("something_went_wrong"))
        #expect(mockService.fetchPokemonCalled)
    }

    @Test func testThatFetchPokemonFailsOnNilResponse() async throws {
        // Arrange
        let mockService = MockPokemonService()
        mockService.fetchPokemonResult = nil
        Container.shared.pokemonService.register { mockService }

        let systemUnderTest = PokemonDetailViewModel(pokemon: NamedItem(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25"))

        // Act
        await systemUnderTest.loadPokemonDetail()

        // Assert
        #expect(systemUnderTest.pokemonDTO == nil)
        #expect(await systemUnderTest.state == ViewState.error("something_went_wrong"))
        #expect(mockService.fetchPokemonCalled)
    }

    deinit {
        Container.shared.reset()
    }
}

