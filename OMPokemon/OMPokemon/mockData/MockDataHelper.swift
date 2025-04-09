//
//  MockDataHelper.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import Foundation

class MockDataHelper {

    static let bundle = Bundle(for: MockDataHelper.self)

    static func readJson<T: Decodable>(from resourceName: String, for type: T.Type) -> T? {
        if let url = MockDataHelper.bundle.url(forResource: resourceName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            } catch {
                return nil
            }
        }
        return nil
    }
}
