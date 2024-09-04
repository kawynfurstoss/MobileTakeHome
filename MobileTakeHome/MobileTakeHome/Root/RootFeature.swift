//
//  RootFeature.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import ComposableArchitecture

@Reducer
struct RootFeature {
    @ObservableState
    struct State: Equatable {
        var placeholder: String = "foo"
        var albums: AlbumsFeature.State
    }
    enum Action {
        case buttonTapped
        case albums(AlbumsFeature.Action)
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
            case .albums(_):
                return .none
            }
        }
        Scope(state: \.albums, action: \.albums) {
            AlbumsFeature()
        }
    }
}
