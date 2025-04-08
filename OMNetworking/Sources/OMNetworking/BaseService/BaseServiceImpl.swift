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

    lazy var _decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    public var decoder: JSONDecoder { _decoder }
}
