//
//  BaseService.swift
//  OMNetworking
//
//  Created by Daniel Jacobs on 2025/04/08.
//
import Foundation
import os

public protocol BaseService {
    var baseUrl: URL { get }
    var decoder: JSONDecoder { get }
    func get<T: Codable>(path: String, type: T.Type) async throws -> T
    func post<T: Codable>(path: String, body: Codable, type: T.Type) async throws -> T
}

extension BaseService {
    public func get<T>(path: String, type: T.Type) async throws -> T where T : Codable {
        guard let url = URL(string: path, relativeTo: baseUrl) else {
            Logger.network.warning("Unable to formulate URL for path: \(path)")
            throw NetworkError.badURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        guard let (data, response) = try? await URLSession.shared.data(for: request) else { throw NetworkError.badRequest }

        Logger.network.info("Response from server: \(response)")

        guard let response = response as? HTTPURLResponse, (200...202).contains(response.statusCode) else {
            Logger.network.warning("Unable to get response.")
            throw NetworkError.badResponse
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch let e as DecodingError {
            Logger.network.error("Decoding error: \(e)")
            throw NetworkError.decoding(e)
        }
    }

    public func post<T: Codable>(path: String, body: Codable, type: T.Type) async throws -> T {
        guard let url = URL(string: path, relativeTo: baseUrl) else {
            Logger.network.warning("Unable to formulate URL for path: \(path)")
            throw NetworkError.badURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        var encodedData: Data?
        do {
            encodedData = try JSONEncoder().encode(body)
        } catch let e as EncodingError {
            Logger.network.error("Decoding error: \(e)")
            throw NetworkError.encoding(e)
        }

        request.httpBody = encodedData

        guard let (data, response) = try? await URLSession.shared.data(for: request) else { throw NetworkError.badRequest }

        if let response = response as? HTTPURLResponse, !(200...202).contains(response.statusCode) {
            Logger.network.warning("Unable to get response.")
            throw NetworkError.badResponse
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch let e as DecodingError {
            Logger.network.error("Decoding error: \(e)")
            throw NetworkError.decoding(e)
        }
    }
}
