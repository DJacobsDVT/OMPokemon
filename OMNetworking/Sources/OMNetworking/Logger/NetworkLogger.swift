//
//  NetworkLogger.swift
//  OMNetworking
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier!

    /// Logs everything related to the networking layer.
    static let network = Logger(subsystem: subsystem, category: "network")
}
