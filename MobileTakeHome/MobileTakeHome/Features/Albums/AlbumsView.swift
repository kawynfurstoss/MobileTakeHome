//
//  AlbumsView.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import SwiftUI
import ComposableArchitecture

struct AlbumsView: View {
    @Bindable var store: StoreOf<AlbumsFeature>

    var body: some View {
        VStack {
            ForEach(store.albums) { album in
                Text(album.id)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    AlbumsView(store: Store(
        initialState: AlbumsFeature.State(albums: AlbumsServiceMockData.mockData),
        reducer: { AlbumsFeature()}
    ))
}
