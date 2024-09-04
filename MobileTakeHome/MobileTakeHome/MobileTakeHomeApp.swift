//
//  MobileTakeHomeApp.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct MobileTakeHomeApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(initialState: RootFeature.State())
                     { RootFeature() }
            )
        }
    }
}
