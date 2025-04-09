import Testing
import OMModels
import Foundation
import Factory
@testable import OMNetworking

@Suite("Pokemon Service Tests", .serialized)
class PokemonServiceTests {

    @Test func testThatFetchPokemonSucceeds() async throws {
        // Arrange
        let mockBaseService = MockBaseServiceImplemention(jsonResourceForGet: "pokemon_list")
        Container.shared.baseService.register { mockBaseService }
        let implementationUnderTest: PokemonService = PokemonServiceImpl()

        await #expect(throws: Never.self) {
            // Act
            let result = try await implementationUnderTest.fetchPokemonList(limit: 100)

            // Assert
            #expect(result?.count ?? 0 > 0)
        }
    }

    @Test func testThatFetchPokemonCacheIsUpdated() async throws {
        // Arrange
        let mockBaseService = MockBaseServiceImplemention(jsonResourceForGet: "pokemon_bulbasaur")
        Container.shared.baseService.register { mockBaseService }

        let implementationUnderTest: PokemonService = PokemonServiceImpl()

        await #expect(throws: Never.self) {
            // Act
            let _ = try await implementationUnderTest.fetchPokemon(named: "bulbasaur")
            let _ = try await implementationUnderTest.fetchPokemon(named: "bulbasaur")

            // Assert
            #expect(mockBaseService.getCalledCount == 1)
        }
    }

    @Test func testThatFetchPokemonCanFail() async throws {
        // Arrange
        let errorToThrow = NetworkError.badRequest
        let mockBaseService = MockBaseServiceImplemention(errorToThrowForGet: errorToThrow)
        Container.shared.baseService.register { mockBaseService }
        let implementationUnderTest: PokemonService = PokemonServiceImpl()

        // Assert
        await #expect(throws: NetworkError.self) {

            // Act
            _ = try await implementationUnderTest.fetchPokemonList(limit: 5)
        }
    }

    @Test func testThatFetchSinglePokemonSucceeds() async throws {
        // Arrange
        let mockBaseService = MockBaseServiceImplemention(jsonResourceForGet: "pokemon_bulbasaur")
        Container.shared.baseService.register { mockBaseService }
        let implementationUnderTest: PokemonService = PokemonServiceImpl()

        await #expect(throws: Never.self) {
            // Act
            let result = try await implementationUnderTest.fetchPokemon(named: "bulbasaur")

            // Assert
            #expect(result != nil)
        }
    }

    @Test func testThatFetchSinglePokemonCanFail() async throws {
        // Arrange
        let errorToThrow = NetworkError.badRequest
        let mockBaseService = MockBaseServiceImplemention(errorToThrowForGet: errorToThrow)
        Container.shared.baseService.register { mockBaseService }
        let implementationUnderTest: PokemonService = PokemonServiceImpl()

        // Assert
        await #expect(throws: NetworkError.self) {

            // Act
            _ = try await implementationUnderTest.fetchPokemon(named: "bulbasaur")
        }
    }

    deinit {
        Container.shared.reset()
    }
}
