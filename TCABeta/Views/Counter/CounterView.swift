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
                Spacer()
                
                PrimaryButton(
                    title: viewStore.isTimerRunning
                    ? "Stop timer"
                    : "Start timer"
                ) {
                    viewStore.send(.toggleTimerButtonTapped)
                }
                
                HStack {
                    Spacer()
                    PrimaryButton(title: "–") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    
                    TitleView(title: "\(viewStore.count)")
                    
                    PrimaryButton(title: "+") {
                        viewStore.send(.incrementButtonTapped)
                    }
                    
                    Spacer()
                }
                
                PrimaryButton(title: "Fact 💡") {
                    viewStore.send(.factButtonTapped)
                }
                .padding(.horizontal)
                
                Group {
                    if viewStore.isLoading {
                        ProgressView()
                    } else {
                        if let fact = viewStore.fact {
                            Text(fact)
                                .multilineTextAlignment(.center)
                        } else {
                            Color.clear
                        }
                    }
                }
                .padding(30)
                .frame(height: UIScreen.main.bounds.height / 3, alignment: .top)
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

