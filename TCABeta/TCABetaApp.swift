//
//  TCABetaApp.swift
//  TCABeta
//
//  Created by ibaikaa on 23/9/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCABetaApp: App {
    @State var store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: store)
        }
    }
}
