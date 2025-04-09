//
//  OMPokemonApp.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI
import Factory
import OMNetworking

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

extension Container {
    var pokemonService: Factory<PokemonService> {
        Factory(self) {
            PokemonServiceImpl()
        }
    }
}
