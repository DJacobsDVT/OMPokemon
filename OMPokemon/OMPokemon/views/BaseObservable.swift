//
//  BaseObservable.swift
//  OMPokemon
//
//  Created by Daniel Jacobs on 2025/04/08.
//

import SwiftUI

protocol BaseObservable: AnyObject, ObservableObject {
    var state: ViewState { get set }
}
