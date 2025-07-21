//
//  TCACounterPlusApp.swift
//  TCACounterPlus
//
//  Created by Sasha Jaroshevskii on 20.07.2025.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCACounterPlusApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: Self.store)
        }
    }
}
