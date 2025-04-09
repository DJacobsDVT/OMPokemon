//
//  Logger.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/09.
//

import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier!

    /// Logs everything related to the main app.
    static let app = Logger(subsystem: subsystem, category: "pokedex_app")
}
