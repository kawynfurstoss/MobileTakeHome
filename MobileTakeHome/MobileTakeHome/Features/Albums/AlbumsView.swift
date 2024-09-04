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
            GeometryReader { geometry in
                let width = geometry.size.width / 3
                SquareGridView(items: store.albums.elements, columnWidth: width) { album in
                    if let image = album.images.first?.imageLink {
                        if let imageUrl = URL(string: image) {
                            AsyncThumbnailView(url: imageUrl, width: width)
                        }
                    }
                }
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
