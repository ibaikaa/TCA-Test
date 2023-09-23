//
//  AddContactFeature.swift
//  TCABeta
//
//  Created by ibaikaa on 24/9/23.
//

import Foundation
import ComposableArchitecture

struct AddContactFeature: Reducer {
    
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action: Equatable {
        enum Delegate: Equatable {
            case saveContact(Contact)
        }
        
        case delegate(Delegate)
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .delegate:
            return .none
            
        case .cancelButtonTapped:
            return .run { _ in await self.dismiss() }
            
        case .saveButtonTapped:
            return .run { [contact = state.contact] send in
                await send(.delegate(.saveContact(contact)))
                await self.dismiss()
            }
            
        case .setName(let name):
            state.contact.name = name
            return .none
        }
        
    }
    
}
