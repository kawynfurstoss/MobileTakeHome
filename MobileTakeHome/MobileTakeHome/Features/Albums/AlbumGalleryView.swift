//
//  AlbumGalleryView.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import SwiftUI
import ComposableArchitecture

struct AlbumGalleryView: View {
    let store: StoreOf<AlbumGalleryFeature>
    
    @State var isFavorite: Bool = true
    var body: some View {
        VStack {
            Text("\(store.state.album.title ?? "null")")
                .font(.title)
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(store.state.album.images) { image in
                            VStack {
                                if let imageUrl = URL(string: image.imageLink) {
                                    AsyncThumbnailView(url: imageUrl, width: geometry.size.width)
                                }
                                HStack {
                                    Spacer()
                                    FavoriteButton(isFavorite: store.favorites.imageFavorites.contains(where: { img in image == img })) { isFavorited in
                                        if isFavorited {
                                            store.send(.imageAddedToFavorites(image))
                                        } else {
                                            store.send(.imageRemovedFromFavorites(image))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
