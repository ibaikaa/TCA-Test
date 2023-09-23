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
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .cancelButtonTapped:
            return .none
            
        case .saveButtonTapped:
            return .none
            
        case .setName(let name):
            state.contact.name = name
            return .none
        }
        
    }
    
}
