//
//  LandingView.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI

struct LandingView: View {

    @EnvironmentObject var router: Router

    var body: some View {
        ZStack {
            Image("pokeball")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.blue)
        }
        .onAppear {
            Task {
                try await performAfterDelay()
            }
        }
    }

    private func performAfterDelay() async throws {
        try await Task.sleep(for: .seconds(1.5))
        withAnimation {
            router.navigate(to: .home)
        }
    }
}

#Preview {
    @ObservedObject var router = Router()

    NavigationStack {
        LandingView().environmentObject(router)
    }
}

