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
    @State var isBottomModalShowing: Bool = false
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ZStack(alignment: .top) {
                GeometryReader { geometry in
                    let width = geometry.size.width / 3
                    if store.isLoading {
                        ProgressView("Loading...")
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    } else {
                        if let albums = store.albums {
                            SquareGridView(items: albums.elements, columnWidth: width) { album in
                                if let image = album.images.first?.imageLink {
                                    if let imageUrl = URL(string: image) {
                                        AsyncThumbnailView(url: imageUrl, width: width)
                                            .onTapGesture {
                                                withAnimation {
                                                    store.send(.albumTapped(album))
                                                    isBottomModalShowing = true
                                                }
                                            }
                                    }
                                }
                            }
                        }
                    }
                }
                SearchBarView(onSearch: { queryText in
                    store.send(.queryAlbums(queryText))
                })
                .padding(.top, Padding.extraLarge * 3)
            }
            .ignoresSafeArea()
            .modifier(BottomModalModifier(
                shouldDisplay: $isBottomModalShowing,
                onDismissed: {
                    withAnimation {
                        isBottomModalShowing = false
                    }
                }
            ) {
                AlbumModal(
                    album: store.selectedAlbum,
                    isFavorite: store.isSelectedAlbumFavorite,
                    onViewGalleryTapped: {
                        store.send(.navigateToAlbumGallery)
                    },
                    onFavoriteTapped: { isFavorited in
                        if let album = store.selectedAlbum {
                            if isFavorited {
                                store.send(.addAlbumToFavorites(album))
                            } else {
                                store.send(.removeAlbumFromFavorites(album))
                            }
                        }
                    }
                )
            }
            )
        }
    destination: { store in
        switch store.case {
        case .albumGallery(let store):
            AlbumGalleryView(store: store)
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
