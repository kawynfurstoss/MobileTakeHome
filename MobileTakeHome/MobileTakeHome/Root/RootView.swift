//
//  RootView.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    @Bindable var store: StoreOf<RootFeature>

    var body: some View {
        VStack {
            CapsuleButton(
                label: store.placeholder,
                onTapped: {
                    store.send(.buttonTapped)
            })
            AlbumsView(store: store.scope(state: \.albums, action: \.albums))
        }
    }
}

#Preview {
    RootView(store: Store(
        initialState: RootFeature.State(),
        reducer: { RootFeature()}
    ))
}
