//
//  Router.swift
//  OMPokemon
//

import SwiftUI
import OMModels

final class Router: ObservableObject {
    @Published var navPath: NavigationPath

     init() {
         self.navPath = NavigationPath()
     }

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}

enum Destination: Hashable {
    case landing
    case home
    case viewPokemon(NamedItem)

    @ViewBuilder var routeView: some View {
        switch self {
        case .landing:
            LandingView().navigationBarBackButtonHidden(true)
        case .home:
            HomeView().navigationBarBackButtonHidden(true)
        case .viewPokemon(let pokemon):
            PokemonDetailView(pokemon: pokemon)
        }
    }
}
