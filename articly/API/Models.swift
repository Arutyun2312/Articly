//
//  Models.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 20.01.23.
//

import BetterCodable
import Foundation

struct Article: Equatable, Codable {
    let id: Int, title, description, author: String, image: URL
    @DateValue<DateOnlyStrategy> var releaseDate: Date

    enum CodingKeys: String, CodingKey {
        case id, title, description, author, releaseDate = "release_date", image
    }
}
