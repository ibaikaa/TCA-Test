//
//  AddContactView.swift
//  TCABeta
//
//  Created by ibaikaa on 24/9/23.
//

import SwiftUI
import ComposableArchitecture

struct AddContactView: View {
    let store: StoreOf<AddContactFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                TextField(
                    "Name",
                    text: viewStore
                        .binding(
                            get: \.contact.name,
                            send: { .setName($0) }
                        )
                )
                
                Button("Save") {
                    viewStore.send(.saveButtonTapped)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        viewStore.send(.cancelButtonTapped)
                    }
                }
            }
        }
    }
    
}

struct AddContactView_Previews: PreviewProvider {
    @State static var store = Store(
        initialState: AddContactFeature.State(
            contact: Contact(id: UUID(), name: "John")
        )
    ) {
        AddContactFeature()
    }
    
    static var previews: some View {
        AddContactView(store: store)
    }
}
