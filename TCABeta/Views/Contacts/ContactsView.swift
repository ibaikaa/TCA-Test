//
//  ContactsView.swift
//  TCABeta
//
//  Created by ibaikaa on 24/9/23.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    let store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationView {
            WithViewStore(store, observe: \.contacts) { viewStore in
                List {
                    ForEach(viewStore.state) { contact in
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Button {
                                viewStore.send(.deleteButtonTapped(id: contact.id))
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .navigationBarTitle("Contacts")
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(
            store: store.scope(
                state: \.$destination,
                action: { .destination($0) }
            ),
            state: /ContactsFeature.Destination.State.addContact,
            action: ContactsFeature.Destination.Action.addContact
        ) { addContactStore in
            NavigationView {
                AddContactView(store: addContactStore)
            }
        }
        .alert(
          store: store.scope(
            state: \.$destination,
            action: { .destination($0) }
          ),
          state: /ContactsFeature.Destination.State.alert,
          action: ContactsFeature.Destination.Action.alert
        )
    }
}

struct ContactsView_Previews: PreviewProvider {
    @State static var store = Store(
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
    }
    
    static var previews: some View {
        ContactsView(store: self.store)
    }
}
