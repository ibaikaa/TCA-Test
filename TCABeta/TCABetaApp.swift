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
    @State var store = Store(
        initialState: ContactsFeature.State(
            contacts: [
                Contact(id: UUID(), name: "John"),
                Contact(id: UUID(), name: "Aibek"),
                Contact(id: UUID(), name: "Vasya"),
                Contact(id: UUID(), name: "Ivan")
            ]
        )
    ) {
        ContactsFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            ContactsView(store: store)
        }
    }
}
