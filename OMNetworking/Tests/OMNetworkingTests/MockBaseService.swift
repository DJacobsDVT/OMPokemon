//
//  MockBaseService.swift
//  OMNetworking
//
//  Created by Daniel Jacobs on 2025/04/09.
//

import Foundation
@testable import OMNetworking

final class MockBaseServiceImplemention: @unchecked Sendable, BaseService {
    var baseUrl: URL {
        URL(string: "https://example.com")!
    }

    var decoder: JSONDecoder {
        JSONDecoder()
    }

    init(jsonResourceForGet: String? = nil,
         errorToThrowForGet: Error? = nil,
         jsonResourceForPost: String? = nil,
         errorToThrowForPost: Error? = nil) {
        self.jsonResourceForGet = jsonResourceForGet
        self.errorToThrowForGet = errorToThrowForGet
        self.jsonResourceForPost = jsonResourceForPost
        self.errorToThrowForPost = errorToThrowForPost
    }

    let jsonResourceForGet: String?
    let errorToThrowForGet: Error?
    var getCalledCount: Int = 0
    func get<T: Codable>(path: String, type: T.Type) async throws -> T {
        getCalledCount += 1
        if let errorToThrowForGet {
            throw errorToThrowForGet
        } else if let jsonResourceForGet {
            return try loadJSONResource(jsonResourceForGet)
        }
        throw NetworkError.badRequest
    }

    let jsonResourceForPost: String?
    let errorToThrowForPost: Error?
    var postCalledCount: Int = 0
    func post<T: Codable>(path: String, body: Codable, type: T.Type) async throws -> T {
        postCalledCount += 1
        if let errorToThrowForPost {
            throw errorToThrowForPost
        } else if let jsonResourceForPost {
            return try loadJSONResource(jsonResourceForPost)
        }
        throw NetworkError.badRequest
    }

    private func loadJSONResource<T: Codable>(_ resourceName: String) throws -> T {
        let bundle = Bundle(for: MockBaseServiceImplemention.self)
        if let url = Bundle.module.url(forResource: resourceName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            } catch {
                throw error
            }
        }
        throw NSError(domain: "", code: 0, userInfo: nil)
    }
}
