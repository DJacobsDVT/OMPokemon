//
//  BaseServiceImpl.swift
//  OMNetworking
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import Foundation

public final class BaseServiceImpl: BaseService {
    public var baseUrl: URL {
        URL(string: "https://pokeapi.co/api/v2/")!
    }

    let _decoder: JSONDecoder = JSONDecoder()

    public var decoder: JSONDecoder { _decoder }

    public init() {}
}
