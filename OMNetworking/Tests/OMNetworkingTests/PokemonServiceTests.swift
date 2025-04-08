import Testing
import OMModels
import Foundation
@testable import OMNetworking

@Suite("Pokemon Service Tests")
class PokemonServiceTests {

    @Test func testThatFetchPokemonSucceeds() async throws {
        let implementationUnderTest: PokemonService = PokemonServiceImpl(baseService: BaseServiceImpl())

        await #expect(throws: Never.self) {
            let result = try await implementationUnderTest.fetchPokemonList(limit: 5)
            #expect(result.count > 0)
        }
    }

    @Test func testThatFetchPokemonCanFail() async throws {
        let errorToThrow = NetworkError.badRequest
        let implementationUnderTest: PokemonService = PokemonServiceImpl(baseService: FailingBaseService(errorToThrow: errorToThrow))

        await #expect(throws: NetworkError.self) {
            _ = try await implementationUnderTest.fetchPokemonList(limit: 5)
        }
    }

    @Test func testThatFetchSinglePokemonSucceeds() async throws {
        let implementationUnderTest: PokemonService = PokemonServiceImpl(baseService: BaseServiceImpl())

        await #expect(throws: Never.self) {
            let result = try await implementationUnderTest.fetchPokemon(named: "Pikachu")
            #expect(result != nil)
        }
    }

    @Test func testThatFetchSinglePokemonCanFail() async throws {
        let errorToThrow = NetworkError.badRequest
        let implementationUnderTest: PokemonService = PokemonServiceImpl(baseService: FailingBaseService(errorToThrow: errorToThrow))

        await #expect(throws: NetworkError.self) {
            _ = try await implementationUnderTest.fetchPokemon(named: "Pikachu")
        }
    }
}
