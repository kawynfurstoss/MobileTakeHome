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
        TabView(selection: $store.selectedTab.sending(\.selectedTabChanged)) {
            AlbumsView(store: store.scope(state: \.albumsTab, action: \.albumsTab))
                .tag(Tab.albums)
                .tabItem {
                    Label(Tab.albums.title, systemImage: Tab.albums.iconName)
                }
            FavoritesView(store: store.scope(state: \.favoritesTab, action: \.favoritesTab))
                .tag(Tab.favorites)
                .tabItem {
                    Label(Tab.favorites.title, systemImage: Tab.favorites.iconName)
                }
        }
    }
}

#Preview {
    RootView(store: Store(
        initialState: RootFeature.State(albumsTab: AlbumsFeature.State(albums: AlbumsServiceMockData.mockData), favoritesTab: FavoritesFeature.State()),
        reducer: { RootFeature()}
    ))
}

enum Tab: CaseIterable{
    case albums,
         favorites
    
    var title: String{
        switch self {
        case .albums:
            return "Albums"
        case .favorites:
            return "Favorites"
        }
    }
    
    var iconName: String{
        switch self {
        case .albums:
            return "rectangle.stack.fill"
        case .favorites:
            return "heart.fill"
        }
    }
}
