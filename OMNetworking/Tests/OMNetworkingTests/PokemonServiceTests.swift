import Testing
import OMModels
import Foundation
import Factory
@testable import OMNetworking

@Suite("Pokemon Service Tests", .serialized)
class PokemonServiceTests {

    @Test func testThatFetchPokemonSucceeds() async throws {
        Container.shared.baseService.register { BaseServiceImpl() }

        let implementationUnderTest: PokemonService = PokemonServiceImpl()

        await #expect(throws: Never.self) {
            let result = try await implementationUnderTest.fetchPokemonList(limit: 5)
            #expect(result?.count ?? 0 > 0)
        }
    }

    @Test func testThatFetchPokemonCanFail() async throws {
        let errorToThrow = NetworkError.badRequest
        Container.shared.baseService.register { FailingBaseService(errorToThrow: errorToThrow) }
        let implementationUnderTest: PokemonService = PokemonServiceImpl()

        await #expect(throws: NetworkError.self) {
            _ = try await implementationUnderTest.fetchPokemonList(limit: 5)
        }
    }

    @Test func testThatFetchSinglePokemonSucceeds() async throws {
        Container.shared.baseService.register { BaseServiceImpl() }
        let implementationUnderTest: PokemonService = PokemonServiceImpl()

        await #expect(throws: Never.self) {
            let result = try await implementationUnderTest.fetchPokemon(named: "Pikachu")
            #expect(result != nil)
        }
    }

    @Test func testThatFetchSinglePokemonCanFail() async throws {
        let errorToThrow = NetworkError.badRequest
        Container.shared.baseService.register { FailingBaseService(errorToThrow: errorToThrow) }
        let implementationUnderTest: PokemonService = PokemonServiceImpl()

        await #expect(throws: NetworkError.self) {
            _ = try await implementationUnderTest.fetchPokemon(named: "Pikachu")
        }
    }

    deinit {
        Container.shared.reset()
    }
}
