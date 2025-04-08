//
//  OMPokemonApp.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI

@main
struct OMPokemonApp: App {

    @ObservedObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                LandingView()
                    .navigationDestination(for: Destination.self) { destination in
                        destination.routeView
                    }
            }
            .environmentObject(router)
        }
    }
}
