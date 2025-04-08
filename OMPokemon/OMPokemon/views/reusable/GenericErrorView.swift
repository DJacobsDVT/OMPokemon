//
//  GenericErrorView.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI

struct GenericErrorView: View {
    var body: some View {
        VStack(spacing: 10.0) {
            Spacer()
            Image(systemName: "figure.fall")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .padding([.bottom])
            Text(String(localized: "generic_error_title"))
                .font(.system(.headline, design: .default))
            Text(String(localized: "something_went_wrong"))
            Spacer()
        }
        .padding()
    }
}

#Preview {
    GenericErrorView()
}
