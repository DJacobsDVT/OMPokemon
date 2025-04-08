//
//  LoadingView.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
            Text(String(localized: "loading"))
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
