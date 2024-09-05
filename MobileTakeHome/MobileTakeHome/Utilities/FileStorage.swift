//
//  FileStorage.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import ComposableArchitecture

extension PersistenceReaderKey
where Self == PersistenceKeyDefault<FileStorageKey<Favorites>> {
    static var favorites: Self {
        PersistenceKeyDefault(
            .fileStorage(.documentsDirectory.appending(component: "favorites.json")),
            Favorites(albumFavorites: [], imageFavorites: [])
        )
    }
}
