//
//  articlyApp.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 20.01.23.
//

import SwiftUI
import URLImage

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
#if !TESTING
            ArticleListView()
                .preferredColorScheme(.dark)
                .environment(\.urlImageOptions, .init(fetchPolicy: .returnStoreElseLoad()))
#endif
        }
    }
}
