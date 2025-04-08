//
//  NetworkError.swift
//  OMNetworking
//
//  Created by Daniel Jacobs on 2025/04/08.
//

public enum NetworkError: Error, CustomStringConvertible {
    case badURL
    case badResponse
    case badRequest
    case decoding(DecodingError)
    case encoding(EncodingError)
    case unknown(Error)

    public var description: String {
        return switch self {
        case .badURL:
            "Misformed URL"
        case .badResponse:
            "Bad Response"
        case .badRequest:
            "Bad Request"
        case .decoding(let decodingError):
            "Decoding Error: \(decodingError.localizedDescription)\n\(decodingError.errorDescription ?? "")"
        case .unknown(let error):
            "Unknown Error: \(error.localizedDescription)"
        case .encoding(let error):
            "Decoding Error: \(error.localizedDescription)"
        }
    }
}
