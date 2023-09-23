//
//  CounterView.swift
//  TCABeta
//
//  Created by ibaikaa on 23/9/23.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 } )  { viewStore in
            VStack {
                PrimaryButton(
                    title: viewStore.isTimerRunning
                    ? "Stop timer"
                    : "Start timer"
                ) {
                    viewStore.send(
                        .toggleTimerButtonTapped,
                        animation: .default
                    )
                }
                
                HStack {
                    Spacer()
                    PrimaryButton(title: "–") {
                        viewStore.send(
                            .decrementButtonTapped,
                            animation: .default
                        )
                    }
                    
                    TitleView(title: "\(viewStore.count)")
                    
                    PrimaryButton(title: "+") {
                        viewStore.send(
                            .incrementButtonTapped,
                            animation: .default
                        )
                    }
                    
                    Spacer()
                }
                
                PrimaryButton(title: "Fact 💡") {
                    viewStore.send(
                        .factButtonTapped,
                        animation: .default
                    )
                }
                .padding(.horizontal)
                
                Group {
                    if viewStore.isLoading {
                        ProgressView()
                    } else if let fact = viewStore.fact {
                        Text(fact)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.top, 15)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: Store(initialState: CounterFeature.State()) {
                CounterFeature()
            }
        )
    }
}

