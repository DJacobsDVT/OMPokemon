//
//  LandingView.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI

struct LandingView: View {

    @EnvironmentObject var router: Router
    @State private var opacity: Double = 0.0

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Color.red
                Color.white
                Color.white
                Color.red
            }
            Image("pokeball")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .opacity(opacity)
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeIn(duration: 1)) {
              opacity = opacity == 0.0 ? 1.0 : 0.0
            }
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

