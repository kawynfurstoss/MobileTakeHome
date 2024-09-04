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
            AlbumsView(store: store.scope(state: \.albums, action: \.albums))
                .ignoresSafeArea()
        }
    }
}

#Preview {
    RootView(store: Store(
        initialState: RootFeature.State(albums: AlbumsFeature.State(albums: AlbumsServiceMockData.mockData)),
        reducer: { RootFeature()}
    ))
}
