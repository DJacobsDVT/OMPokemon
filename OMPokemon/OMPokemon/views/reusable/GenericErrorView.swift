//
//  GenericErrorView.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI

struct GenericErrorView: View {

    let errorMessage: String

    var body: some View {
        VStack(spacing: 10.0) {
            Spacer()
            Image(systemName: "figure.fall")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .padding([.bottom])
            Text("generic_error_title")
                .font(.system(.headline, design: .default))
            Text(errorMessage)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    GenericErrorView(errorMessage: "something_went_wrong")
}
