//
//  FailingBaseService.swift
//  OMNetworking
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import Foundation
@testable import OMNetworking

class FailingBaseService: BaseService {
    var baseUrl: URL { return URL(string: "")! }

    var decoder: JSONDecoder { JSONDecoder() }

    let errorToThrow: Error

    init(errorToThrow: Error) {
        self.errorToThrow = errorToThrow
    }

    func get<T: Codable>(path: String, type: T.Type) async throws -> T {
        throw errorToThrow
    }

    func post<T: Codable>(path: String, body: Codable, type: T.Type) async throws -> T {
        throw errorToThrow
    }
}
