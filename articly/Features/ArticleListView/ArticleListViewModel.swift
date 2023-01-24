//
//  ArticleListViewModel.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 20.01.23.
//

import Foundation
import SecureDefaults

@MainActor
final class ArticleListViewModel: ObservableObject {
    @Published var articles = ArticleStorage.shared.articles {
        didSet {
            ArticleStorage.shared.articles = articles
        }
    }

    @Published var hasError = false
    @Published var isLoading = true

    /// Load articles and sort them
    func load() async {
        hasError = false
        isLoading = true
        do {
            articles = try await API.getArticles().sorted { $0.releaseDate > $1.releaseDate }
        } catch {
            hasError = true
        }
        isLoading = false
    }
}
