//
//  CounterFeature.swift
//  TCABeta
//
//  Created by ibaikaa on 24/9/23.
//

import Foundation
import ComposableArchitecture

struct CounterFeature: Reducer {
    
    // MARK: State
    
    struct State: Equatable {
        var count = 0
        var fact: String?
        var error: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    // MARK: CancelID
    
    enum CancelID { case timer }
    
    // MARK: Action
    
    enum Action {
        case incrementButtonTapped
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case errorResponse(Error)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    // MARK: reduce() method
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            state.error = nil
            state.isTimerRunning = false
            
            return .cancel(id: CancelID.timer)
            
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            state.error = nil
            state.isTimerRunning = false
            
            return .cancel(id: CancelID.timer)
            
        case .factButtonTapped:
            state.isLoading = true
            
            return .run(priority: .userInitiated) { [count = state.count] send in
                let fact = try await fetchFactForNumber(count)
                await send(.factResponse(fact))
            } catch: { error, send in
                await send(.errorResponse(error))
            }
            
        case .factResponse(let fact):
            state.fact = fact
            state.isLoading = false
            state.isTimerRunning = false
            
            return .cancel(id: CancelID.timer)
            
        case .errorResponse(let error):
            state.fact = error.localizedDescription
            state.isLoading =  false
            
            return .cancel(id: CancelID.timer)
            
        case .timerTick:
            state.count += 1
            state.fact = nil
            
            return .none
            
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            state.fact = nil
            
            if state.isTimerRunning {
                return .run { send in
                    while true {
                        try await Task.sleep(seconds: 1.0)
                        await send(.timerTick)
                    }
                } catch: { error, send in
                    await send(.errorResponse(error))
                }
                .cancellable(id: CancelID.timer)
            } else {
                return .cancel(id: CancelID.timer)
            }
        }
    }
    
    // MARK: Private properties
    
    private var baseURL: String { "http://numbersapi.com/" }
    
    // MARK: Private methods
    
    private func fetchFactForNumber(_ number: Int) async throws -> String {
        guard let url = URL(string: baseURL + "\(number)") else {
            throw ApiError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(decoding: data, as: UTF8.self)
    }
    
}

fileprivate enum ApiError: Error {
    case invalidURL
}

fileprivate extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
