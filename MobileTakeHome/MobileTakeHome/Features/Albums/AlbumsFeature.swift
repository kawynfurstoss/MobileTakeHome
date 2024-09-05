//
//  AlbumsFeature.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import ComposableArchitecture

@Reducer
struct AlbumsFeature {
    @ObservableState
    struct State: Equatable {
        var albums: IdentifiedArrayOf<Album>?
        var selectedAlbum: Album?
        var isLoading: Bool = false
        @Shared(.favorites) var favorites
        @Presents var destination: Destination.State?
        var path = StackState<Path.State>()
        var isSelectedAlbumFavorite: Bool = false
    }
    enum Action {
        case queryAlbums(String)
        case albumsQueried(Result<IdentifiedArrayOf<Album>, Error>)
        case albumTapped(Album)
        case navigateToAlbumGallery
        case addAlbumToFavorites(String)
        case removeAlbumFromFavorites(String)
        case destination(PresentationAction<Destination.Action>)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    @Dependency(\.albumService) var albumService
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .queryAlbums(query):
                state.isLoading = true
                return .run { send in
                    do {
                        let albums = try await albumService.queryAlbums(query)
                        await send(.albumsQueried(.success(albums)))
                    } catch {
                        await send(.albumsQueried(.failure(error)))
                    }
                }
            case let .albumsQueried(.success(albums)):
                state.albums = albums
                state.isLoading = false
                return .none
            case let .albumsQueried(.failure(error)):
                state.isLoading = false
                return .none
            case let .albumTapped(album):
                state.selectedAlbum = album
                state.isSelectedAlbumFavorite = state.favorites.albumFavorites.contains(where: { str in album.id == str })
                return .none
            case .navigateToAlbumGallery:
                guard let album = state.selectedAlbum else {
                    return .none
                }
                state.path.append(.albumGallery(AlbumGalleryFeature.State(album: album)))
                return .none
            case .destination:
                    return .none
            case .path:
                    return .none
            case let .addAlbumToFavorites(id):
                state.favorites.albumFavorites.append(id)
                state.isSelectedAlbumFavorite = true
                return .none
            case let .removeAlbumFromFavorites(id):
                state.favorites.albumFavorites.removeAll(where: { str in
                id == str
                })
                state.isSelectedAlbumFavorite = false
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
        .forEach(\.path, action: \.path)
    }
}

extension AlbumsFeature {
    @Reducer(state: .equatable)
    enum Destination {
      case albumGallery(AlbumGalleryFeature)
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case albumGallery(AlbumGalleryFeature)
    }
}
