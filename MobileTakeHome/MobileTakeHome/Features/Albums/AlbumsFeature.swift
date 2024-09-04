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
        var albums: IdentifiedArrayOf<Album>
        var selectedAlbum: Album?
        var isLoading: Bool = false
        @Presents var destination: Destination.State?
        var path = StackState<Path.State>()
    }
    enum Action {
        case queryAlbums(String)
        case albumsQueried(Result<IdentifiedArrayOf<Album>, Error>)
        case albumTapped(Album)
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
                return .none
            case .destination:
                    return .none
            case .path:
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
