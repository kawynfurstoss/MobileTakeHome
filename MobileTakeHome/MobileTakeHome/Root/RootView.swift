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
        CapsuleButton(
            label: store.placeholder,
            onTapped: {
                store.send(.buttonTapped)
            })
    }
}

#Preview {
    RootView(store: Store(
        initialState: RootFeature.State(),
        reducer: { RootFeature()}
    ))
}
