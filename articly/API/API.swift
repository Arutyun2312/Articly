//
//  API.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 20.01.23.
//

import Foundation

struct APIConfig {
    var getArticles: @Sendable () async throws -> Data = { try await API.getData("https://run.mocky.io/v3/de42e6d9-2d03-40e2-a426-8953c7c94fb8") }
}

enum API {
    static let decoder = JSONDecoder()
    
    fileprivate static func getData(_ url: String) async throws -> Data {
        guard let url = URL(string: url) else { throw Errors.invalidUrl(url) }
        return try await URLSession.shared.data(for: .init(url: url)).0
    }
    
    /// Used for stub
    static var config = APIConfig()
    
    static func getArticles() async throws -> [Article] {
        let data = try await AsyncTask.retrying(count: 3) { try await config.getArticles() }
        return try decoder.decode([Article].self, from: data)
    }
    
    enum Errors: Error {
        case invalidUrl(String)
    }
}

