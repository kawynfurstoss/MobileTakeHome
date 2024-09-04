//
//  RootFeature.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import ComposableArchitecture
import UIKit

@Reducer
struct RootFeature {
    @ObservableState
    struct State: Equatable { 
        var placeholder: String = "foo"
    }
    enum Action {
        case buttonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .buttonTapped:
                guard state.placeholder == "foo" else {
                    state.placeholder = "foo"
                    return .none
                }
                state.placeholder = "bar"
                return .none
            }
        }
    }
}
