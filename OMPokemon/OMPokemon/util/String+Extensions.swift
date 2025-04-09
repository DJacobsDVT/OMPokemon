//
//  String+Extensions.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/09.
//

extension String {
    func caseInsenstiveContains(_ comparisonString: String) -> Bool {
        self.lowercased().contains(comparisonString.lowercased())
    }
}
