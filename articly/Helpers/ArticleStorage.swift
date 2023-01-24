//
//  ArticleStorage.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 24.01.23.
//

import Foundation
import SecureDefaults

/// Key used in user defaults
private let articlesKey = "articlesKey"

/// Stores articles in user defaults as encrypted data
final class ArticleStorage {
    static let shared = ArticleStorage()
    
    let defaults = SecureDefaults.shared
    
    private init() {
        // Need to set pw for 1st time
        if !defaults.isKeyCreated {
            defaults.password = ProcessInfo.processInfo.globallyUniqueString
        }
    }
    
    var articles: [Article]? {
        get {
            guard let data = defaults.data(forKey: articlesKey), let articles = try? JSONDecoder().decode([Article].self, from: data) else { return nil }
            return articles
        }
        set {
            guard let articles = newValue, let data = try? JSONEncoder().encode(articles) else { return }
            defaults.set(data, forKey: articlesKey)
        }
    }
}
